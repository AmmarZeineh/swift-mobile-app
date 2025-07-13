import 'package:dartz/dartz.dart';
import 'package:swift_mobile_app/core/errors/failure.dart';
import 'package:swift_mobile_app/features/client/cart/domain/Entities/cart_entity.dart';
import 'package:swift_mobile_app/features/client/home/domain/entities/product_entity.dart';

abstract class CartRepo {
  Future<Either<Failure, List<CartEntity>>> fetchCartItems({
    required String userId,
  });
  Future<Either<Failure, List<ProductEntity>>> fetchProductsByIds(
    List<int> ids,
  );
  Future<Either<Failure, void>> deleteCartItem(int cartItemId);
  Future<Either<Failure, void>> addOrder({required String userId,required String address,String state});
}
