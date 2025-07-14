import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:swift_mobile_app/core/entities/product_entity.dart';
import 'package:swift_mobile_app/core/errors/failure.dart';
import 'package:swift_mobile_app/features/seller/add_product/domain/entities/category_entity.dart';

abstract class AddProductRepo {
  Future<Either<Failure, List<CategoryEntity>>> fetchCategories();
  Future<Either<Failure, void>> addProduct(
    List<File> images,
    ProductEntity productEntity,
    int sellerId
  );
}
