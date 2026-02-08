part of 'cart_item_cubit.dart';

@immutable
 class CartItemState {}

 class CartItemInitial extends CartItemState {}

 class CartItemLoading extends CartItemState {}

 class CartItemSuccess extends CartItemState {
  final List<CartItemWithProductEntity> carts;
  CartItemSuccess(this.carts);
}

 class CartItemFailure extends CartItemState {
  final String errMessage;
  CartItemFailure(this.errMessage);
}
