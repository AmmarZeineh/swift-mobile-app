
import 'package:dartz/dartz.dart';
import 'package:swift_mobile_app/core/entities/review_entity.dart';
import 'package:swift_mobile_app/core/errors/failure.dart';
import 'package:swift_mobile_app/core/models/review_model.dart';
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
        columnValue: productId,
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
        columnValue: categoryId,
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

  @override
  Future<Either<Failure, void>> addToCart(
    String userId,
    int productId,
    int quantity,
    double price,
    String selectedAttributesSummary,
  ) async {
    try {
      await dataBaseServic.addData(
        path: BackendEndpoints.cart,
        data: {
          "user_id": userId,
          "product_id": productId,
          "quantity": quantity,
          "price": price,
          "selected_attributes_summary": selectedAttributesSummary,
        },
      );
      return Right(null);
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ReviewEntity>>> fetchReviewsForProduct(
    int productId,
  ) async {
    try {
      final data = await dataBaseServic.getData(
        path: 'reviews',
        columnName: 'product_id',
        columnValue: productId,
      );

      final reviews =
          (data as List)
              .map((json) => ReviewModel.fromJson(json).toEntity())
              .toList();

      return Right(reviews);
    } catch (e) {
      return Left(ServerFailure('فشل تحميل التقييمات: ${e.toString()}'));
    }
  }
}
