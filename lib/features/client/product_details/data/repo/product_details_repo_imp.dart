import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:swift_mobile_app/core/errors/failure.dart';
import 'package:swift_mobile_app/core/services/backend_endpoints.dart';
import 'package:swift_mobile_app/core/services/database_service.dart';
import 'package:swift_mobile_app/features/client/product_details/data/models/product_attribute_model.dart';
import 'package:swift_mobile_app/features/client/product_details/data/models/product_attribute_value_model.dart';
import 'package:swift_mobile_app/features/client/product_details/domain/entities/product_attribute_entity.dart';
import 'package:swift_mobile_app/features/client/product_details/domain/entities/product_attribute_value_entity.dart';
import 'package:swift_mobile_app/features/client/product_details/domain/repo/product_details_repo.dart';

class ProductDetailsRepoImp implements ProductDetailsRepo {
  final DataBaseService dataBaseServic;

  ProductDetailsRepoImp(this.dataBaseServic);

  @override
  Future<Either<ServerFailure, List<ProductAttributeValueEntity>>>
  getProductAttributeValues(int productId) async {
    try {
      List<ProductAttributeValueEntity> attributeValues = [];
      var data = await dataBaseServic.getData(
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
      var data = await dataBaseServic.getData(
        path: BackendEndpoints.attributes,
        columnName: "category_id",
        columnValue: categoryId.toString(),
      );
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
}
