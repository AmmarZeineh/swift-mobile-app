import 'dart:developer';

import 'package:dartz/dartz.dart';
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

  HomeRepoImpl(this.dataBaseService);
  @override
  Future<Either<Failure, List<CategoryCardEntity>>> fetchCategories() async {
    try {
      List<CategoryCardEntity> categories = [];
      var data = await dataBaseService.getData(
        tableName: BackendEndpoints.categories,
      );
      for (var i = 0; i < data.length; i++) {
        categories.add(CategoryModel.fromJson(data[i]).toEntity());
      }
      return Right(categories);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> fetchProducts() async {
    try {
      List<ProductEntity> products = [];

      var data = await dataBaseService.getData(
        tableName: BackendEndpoints.products,
      );
      for (var i = 0; i < data.length; i++) {
        log(data[i].toString());

        products.add(ProductModel.fromJson(data[i]).toEntity());
      }

      return Right(products);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
