import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:swift_mobile_app/core/errors/failure.dart';
import 'package:swift_mobile_app/core/services/backend_endpoints.dart';
import 'package:swift_mobile_app/core/services/database_service.dart';
import 'package:swift_mobile_app/features/client/cart/data/models/cart_model.dart';
import 'package:swift_mobile_app/features/client/cart/domain/Entities/cart_entity.dart';
import 'package:swift_mobile_app/features/client/cart/domain/repos/cart_repo.dart';

import '../../../../../core/entities/product_entity.dart';
import '../../../../../core/models/product_model.dart';

class CartRepoImp implements CartRepo {
  final DataBaseService dataBaseService;
  CartRepoImp(this.dataBaseService);

  @override
  Future<Either<Failure, List<ProductEntity>>> fetchProductsByIds(
    List<int> ids,
  ) async {
    try {
      final data = await dataBaseService.getDataByIds(
        path: BackendEndpoints.products,
        columnName: 'id',
        values: ids,
      );

      final products = data
          .map((e) => ProductModel.fromJson(e).toEntity())
          .toList();
      return Right(products);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CartEntity>>> fetchCartItems({
    required String userId,
  }) async {
    try {
      List<CartEntity> cartItems = [];
      var data = await dataBaseService.getData(
        path: BackendEndpoints.cart,
        columnName: "user_id",
        columnValue: userId,
      );

      for (var i = 0; i < data.length; i++) {
        cartItems.add(CartModel.fromJson(data[i]).toEntity());
      }
      return Right(cartItems);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteCartItem(int cartItemId) async {
    try {
      await dataBaseService.deleteData(
        path: BackendEndpoints.cart,
        columnName: "id",
        columnValue: cartItemId.toString(),
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addOrder({
    required String userId,
    required String address,
    String state = "معلق",
  }) async {
    try {
      final cartItems = await dataBaseService.getData(
        path: BackendEndpoints.cart,
        columnName: "user_id",
        columnValue: userId,
      );

      if (cartItems.isEmpty) {
        throw Exception('السلة فارغة');
      }

      final orderResponse = await Supabase.instance.client
          .from("orders")
          .insert({'user_id': userId, 'state': state, 'address': address})
          .select()
          .single();

      final orderId = orderResponse['id'];

      // إضافة عناصر السلة كـ order_items
      List<Map<String, dynamic>> orderItems = [];
      for (var cartItem in cartItems) {
        orderItems.add({
          'order_id': orderId,
          'product_id': cartItem['product_id'],
          'quantity': cartItem['quantity'],
          'price': cartItem['price'] ?? 0.0,
          'selected_attributes_summary':
              cartItem['selected_attributes_summary'],
        });
      }

      await Supabase.instance.client.from('order_items').insert(orderItems);

      await Supabase.instance.client
          .from('cart_items')
          .delete()
          .eq('user_id', userId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
