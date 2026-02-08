part of 'seller_login_cubit.dart';

@immutable
 class SellerLoginState {}

 class SellerLoginInitial extends SellerLoginState {}

 class SellerLoginLoading extends SellerLoginState {}

 class SellerLoginSuccess extends SellerLoginState {
  final SellerEntity sellerEntity;

  SellerLoginSuccess(this.sellerEntity);
}

 class SellerLoginFailure extends SellerLoginState {
  final String errMessage;

  SellerLoginFailure(this.errMessage);
}
