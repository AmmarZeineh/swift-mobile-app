import 'package:dartz/dartz.dart';
import 'package:swift_mobile_app/core/entities/product_attribute_entity.dart';
import 'package:swift_mobile_app/core/entities/product_attribute_value_entity.dart';
import 'package:swift_mobile_app/core/errors/failure.dart';
import 'package:swift_mobile_app/features/seller/home/domain/entities/product_entity.dart';

abstract class SellerHomeRepo {
  Future<Either<Failure, List<ProductEntity>>> getProducts(int id);
  Future<Either<ServerFailure, List<ProductAttributeValueEntity>>>
  getProductAttributeValues(int productId);

  Future<Either<ServerFailure, List<ProductAttributeEntity>>>
  getProductAttributes(int categoryId);
}
