import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:swift_mobile_app/core/errors/failure.dart';
import 'package:swift_mobile_app/core/services/backend_endpoints.dart';
import 'package:swift_mobile_app/core/services/database_service.dart';
import 'package:swift_mobile_app/features/client/home/data/models/category_model.dart';
import 'package:swift_mobile_app/features/client/home/data/models/product_model.dart';
import 'package:swift_mobile_app/features/client/home/domain/entities/category_card_entity.dart';
import 'package:swift_mobile_app/features/client/home/domain/entities/product_entity.dart';
import 'package:swift_mobile_app/features/client/home/domain/repos/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  final DataBaseService dataBaseService;
  final SupabaseClient supabaseClient;

  HomeRepoImpl(this.dataBaseService, {required this.supabaseClient});
  @override
  Future<Either<Failure, List<CategoryCardEntity>>> fetchCategories() async {
    try {
      List<CategoryCardEntity> categories = [];
      var data = await dataBaseService.getData(
        path: BackendEndpoints.categories,
      );
      for (var i = 0; i < data.length; i++) {
        categories.add(CategoryModel.fromJson(data[i]).toEntity());
      }
      List<CategoryCardEntity> reversedCategories =
          categories.reversed.toList();
      return Right(reversedCategories);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> searchProducts({
    required String keyword,
    int? categoryId,
  }) async {
    try {
      List<ProductEntity> products = [];
      var data = await dataBaseService.getData(path: BackendEndpoints.products);

      for (var i = 0; i < data.length; i++) {
        ProductEntity product = ProductModel.fromJson(data[i]).toEntity();

        final matchCategory =
            categoryId == null || product.categoryId == categoryId;
        final matchKeyword = product.name.toLowerCase().contains(
          keyword.toLowerCase(),
        );

        if (matchCategory && matchKeyword) {
          products.add(product);
        }
      }

      return Right(products);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> fetchProducts({
    int? categoryId,
    int offset = 0,
    int limit = 10,
  }) async {
    try {
      final data = await supabaseClient
          .from(BackendEndpoints.products)
          .select()
          .range(offset, offset + limit - 1); // Supabase pagination

      final List<ProductEntity> products = [];

      for (final item in data) {
        final product = ProductModel.fromJson(item).toEntity();
        if (categoryId == null || product.categoryId == categoryId) {
          products.add(product);
        }
      }

      return Right(products);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
