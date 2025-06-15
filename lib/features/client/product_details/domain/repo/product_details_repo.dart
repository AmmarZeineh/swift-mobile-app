import 'package:dartz/dartz.dart';
import 'package:swift_mobile_app/core/errors/failure.dart';
import 'package:swift_mobile_app/features/client/product_details/domain/entities/product_attribute_entity.dart';
import 'package:swift_mobile_app/features/client/product_details/domain/entities/product_attribute_value_entity.dart';

abstract class ProductDetailsRepo {

  Future<Either<Failure, List<ProductAttributeValueEntity>>> getProductAttributeValues(int productId);
  Future<Either<Failure, List<ProductAttributeEntity>>> getProductAttributes(int categoryId);

}
