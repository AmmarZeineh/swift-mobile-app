import 'package:dartz/dartz.dart';
import 'package:swift_mobile_app/core/entities/product_attribute_entity.dart';
import 'package:swift_mobile_app/core/entities/product_attribute_value_entity.dart';
import 'package:swift_mobile_app/core/errors/failure.dart';
import 'package:swift_mobile_app/features/seller/home/domain/entities/product_entity.dart';
import 'package:swift_mobile_app/features/seller/home/domain/entities/review_entity.dart';

abstract class SellerHomeRepo {
  Future<Either<Failure, List<ProductEntity>>> getProducts(int id);
  Future<Either<ServerFailure, List<ProductAttributeValueEntity>>>
  getProductAttributeValues(int productId);

  Future<Either<ServerFailure, List<ProductAttributeEntity>>>
  getProductAttributes(int categoryId);

  Future<Either<ServerFailure, void>> editProductDetails(
    String columnName,
    String columnValue,
    Map<String, dynamic> newData,
  );

  Future<Either<ServerFailure, void>> editAttributeValue(
    String string,
    int attributeId,
    int valueId,
    String newValue,
  );

  Future<Either<ServerFailure, void>> deleteAttributeValue(
    String string,
    int attributeId,
    int valueId,
  );

  Future<Either<ServerFailure, void>> addAttributeValue(
    String string,
    int attributeId,
    String newValue,
  );

  Future<Either<ServerFailure, List<ReviewEntity>>> getProductReviews(ProductEntity productEntity);
}
