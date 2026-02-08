import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:swift_mobile_app/core/entities/product_attribute_entity.dart';
import 'package:swift_mobile_app/core/entities/product_attribute_value_entity.dart';
import 'package:swift_mobile_app/core/entities/product_entity.dart';
import 'package:swift_mobile_app/core/errors/failure.dart';
import 'package:swift_mobile_app/core/models/product_attribute_model.dart';
import 'package:swift_mobile_app/core/models/product_attribute_value_model.dart';
import 'package:swift_mobile_app/core/models/product_model.dart';
import 'package:swift_mobile_app/core/services/backend_endpoints.dart';
import 'package:swift_mobile_app/core/services/database_service.dart';
import 'package:swift_mobile_app/features/seller/home/domain/repos/seller_home_repo.dart';

import '../../../../../core/entities/review_entity.dart';
import '../../../../../core/models/review_model.dart';

class SellerHomeRepoImpl implements SellerHomeRepo {
  final DataBaseService _dataBaseService;

  SellerHomeRepoImpl(this._dataBaseService);

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts(int id) async {
    try {
      var result = await _dataBaseService.getData(
        path: BackendEndpoints.products,
        columnName: 'seller_id',
        columnValue: id,
      );
      log(result.toString());
      List<ProductEntity> products = [];
      for (var i = 0; i < result.length; i++) {
        log(result.toString());
        products.add(ProductModel.fromJson(result[i]).toEntity());
      }
      return Right(products);
    } catch (e) {
      log(e.toString());
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<ServerFailure, List<ProductAttributeValueEntity>>>
      getProductAttributeValues(int productId) async {
    try {
      List<ProductAttributeValueEntity> attributeValues = [];
      var data = await _dataBaseService.getData(
        path: BackendEndpoints.attributesValues,
        columnName: "product_id",
        columnValue: productId.toString(),
      );

      for (var i = 0; i < data.length; i++) {
        attributeValues.add(AttributeValueModel.fromJson(data[i]).toEntity());
      }
      return Right(attributeValues);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<ServerFailure, List<ProductAttributeEntity>>>
      getProductAttributes(int categoryId) async {
    try {
      List<ProductAttributeEntity> productAttributes = [];
      var data = await _dataBaseService.getData(
        path: BackendEndpoints.attributes,
        columnName: "category_id",
        columnValue: categoryId.toString(),
      );
      log(data.toString());
      for (var i = 0; i < data.length; i++) {
        productAttributes.add(
          ProductAttributeModel.fromJson(data[i]).toEntity(),
        );
      }
      return Right(productAttributes);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<ServerFailure, void>> editProductDetails(
    String columnName,
    String columnValue,
    Map<String, dynamic> newData,
  ) async {
    try {
      await _dataBaseService.updateData(
        data: newData,
        path: BackendEndpoints.products,
        columnName: columnName,
        columnValue: columnValue,
      );
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<ServerFailure, void>> editAttributeValue(
    String productId,
    int attributeId,
    int valueId,
    String newValue,
  ) async {
    try {
      await _dataBaseService.updateData(
        data: {'value': newValue},
        path: BackendEndpoints.attributesValues,
        columnName: 'id',
        columnValue: valueId.toString(),
      );
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<ServerFailure, void>> addAttributeValue(
    String productId,
    int attributeId,
    String newValue,
  ) async {
    try {
      await _dataBaseService.addData(
        data: {
          'product_id': productId,
          'attribute_id': attributeId,
          'value': newValue,
        },
        path: BackendEndpoints.attributesValues,
      );
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<ServerFailure, void>> deleteAttributeValue(
    String productId,
    int attributeId,
    int valueId,
  ) async {
    try {
      await _dataBaseService.deleteData(
        path: BackendEndpoints.attributesValues,
        columnName: 'id',
        columnValue: valueId.toString(),
      );
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<ServerFailure, List<ReviewEntity>>> getProductReviews(
    ProductEntity productEntity,
  ) async {
    try {
      List<ReviewEntity> reviews = [];
      var data = await _dataBaseService.getData(
        path: BackendEndpoints.reviews,
        columnName: "product_id",
        columnValue: productEntity.id.toString(),
      );
      log(data.toString());
      for (var i = 0; i < data.length; i++) {
        reviews.add(ReviewModel.fromJson(data[i]).toEntity());
      }
      return Right(reviews);
    } catch (e) {
      log(e.toString());
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProduct(int id) async {
    try {
      await _dataBaseService.deleteData(
        path: BackendEndpoints.attributesValues,
        columnName: 'product_id',
        columnValue: id.toString(),
      );
      await _dataBaseService.deleteData(
        path: BackendEndpoints.reviews,
        columnName: 'product_id',
        columnValue: id.toString(),
      );
      await _dataBaseService.deleteData(
        path: BackendEndpoints.products,
        columnName: 'id',
        columnValue: id.toString(),
      );
      return Right(null);
    } catch (e) {
      log(e.toString());
      return Left(ServerFailure(e.toString()));
    }
  }
}
