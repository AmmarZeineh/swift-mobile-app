part of 'add_to_cart_cubit.dart';

@immutable
sealed class AddToCartState {}

final class AddToCartInitial extends AddToCartState {}

final class AddToCartLoading extends AddToCartState {}

final class AddToCartSuccess extends AddToCartState {
  final ProductEntity product;
  AddToCartSuccess(this.product);
}

final class AddToCartFailure extends AddToCartState {
  final String errMessage;
  AddToCartFailure(this.errMessage);
}
