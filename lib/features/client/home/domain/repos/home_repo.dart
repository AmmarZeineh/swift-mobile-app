import 'package:dartz/dartz.dart';
import 'package:swift_mobile_app/core/errors/failure.dart';
import 'package:swift_mobile_app/features/client/home/domain/entities/category_card_entity.dart';
import 'package:swift_mobile_app/features/client/home/domain/entities/product_entity.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<CategoryCardEntity>>> fetchCategories();
   Future<Either<Failure, List<ProductEntity>>> fetchProducts();
}
