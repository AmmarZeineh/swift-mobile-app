
import 'package:swift_mobile_app/features/client/cart/domain/Entities/cart_item_with_product.dart';




sealed class CartItemState {}

final class CartItemInitial extends CartItemState {}

final class CartItemLoading extends CartItemState {}

final class CartItemSuccess extends CartItemState {
  final List<CartItemWithProductEntity> carts;
  CartItemSuccess(this.carts);
}

final class CartItemFailure extends CartItemState {
  final String errMessage;
  CartItemFailure(this.errMessage);
}
