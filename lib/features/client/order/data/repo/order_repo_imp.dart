import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:swift_mobile_app/core/entities/review_entity.dart';
import 'package:swift_mobile_app/core/errors/failure.dart';
import 'package:swift_mobile_app/core/models/product_model.dart';
import 'package:swift_mobile_app/core/services/backend_endpoints.dart';
import 'package:swift_mobile_app/core/services/database_service.dart';
import 'package:swift_mobile_app/features/client/auth/domain/entities/client_entity.dart';
import 'package:swift_mobile_app/features/client/order/data/models/order_model.dart';
import 'package:swift_mobile_app/features/client/order/domain/entities/order_entity.dart';
import 'package:swift_mobile_app/features/client/order/domain/repo/order_repo.dart';

import '../../../../../core/entities/product_entity.dart';

class OrdersRepoImp implements OrdersRepo {
  final SupabaseClient supabaseClient;
  final DataBaseService dataBaseService;

  OrdersRepoImp(this.dataBaseService,{required this.supabaseClient});

  Future<Either<Failure, List<ProductEntity>>> fetchProductsByIds(
    List<int> ids,
  ) async {
    try {
      final data = await dataBaseService.getDataByIds(
        path: BackendEndpoints.products,
        columnName: 'id',
        values: ids,
      );

      final products =
          data.map((e) => ProductModel.fromJson(e).toEntity()).toList();
      return Right(products);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<OrderEntity>>> getUserOrders(
    String userId,
  ) async {
    try {
      final response = await supabaseClient
          .from('orders')
          .select('''
          *,
          order_items (
            *
          )
        ''')
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      final ordersRaw = response as List<dynamic>;

      final orders =
          ordersRaw.map((order) => OrderModel.fromJson(order)).toList();

      // تجميع كل الـ productIds من الطلبات
      final allProductIds =
          orders
              .expand((order) => order.items)
              .map((item) => int.tryParse(item.productId))
              .whereType<int>()
              .toSet()
              .toList();

      if (allProductIds.isEmpty) return Right(orders); // ما في منتجات نجيبها

      // جلب معلومات المنتجات
      final productsResult = await fetchProductsByIds(allProductIds);
      if (productsResult.isLeft()) {
        return Left(productsResult.fold((l) => l, (_) => ServerFailure('')));
      }

      final products = productsResult.getOrElse(() => []);

      for (final order in orders) {
        for (final item in order.items) {
          final product = products.firstWhere(
            (p) => p.id.toString() == item.productId,
            // ignore: cast_from_null_always_fails
            orElse: () => null as ProductEntity,
          );
          item.price=product.price;
          item.productName = product.name;
          item.productImage =
              product.image.isNotEmpty ? product.image.first : null;
        }
      }

      return Right(orders);
    } catch (e) {
      return Left(ServerFailure('فشل في جلب الطلبات: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> cancelOrder(String orderId) async {
    try {
      await supabaseClient
          .from('orders')
          .update({'state': 'ملغي'})
          .eq('id', orderId);

      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('فشل في إلغاء الطلب: ${e.toString()}'));
    }
  }
  @override
  Future<Either<Failure, void>> rateProduct(
    ClientEntity clientEntity,
    ReviewEntity review,
  ) async {
    try {
      var response = await supabaseClient
          .from(BackendEndpoints.reviews)
          .select()
          .eq('user_id', clientEntity.id)
          .eq('product_id', review.productId);

      if (response.isNotEmpty) {
        await dataBaseService.deleteData(
          path: BackendEndpoints.reviews,
          columnName: 'id',
          columnValue: response[0]['id'],
        );
        await dataBaseService.addData(
          data: {
            'product_id': review.productId,
            'user_id': clientEntity.id,
            'user_name': clientEntity.userName,
            'rating': review.rate,
            'comment': review.comment,
          },
          path: BackendEndpoints.reviews,
        );
      } else {
        await dataBaseService.addData(
          data: {
            'product_id': review.productId,
            'user_id': clientEntity.id,
            'user_name': clientEntity.userName,
            'rating': review.rate,
            'comment': review.comment,
          },
          path: BackendEndpoints.reviews,
        );
      }
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
