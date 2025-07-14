part of 'add_to_cart_cubit.dart';

@immutable
 class AddToCartState {}

 class AddToCartInitial extends AddToCartState {}

 class AddToCartLoading extends AddToCartState {}

 class AddToCartSuccess extends AddToCartState {
  final ProductEntity product;
  AddToCartSuccess(this.product);
}

 class AddToCartFailure extends AddToCartState {
  final String errMessage;
  AddToCartFailure(this.errMessage);
}
