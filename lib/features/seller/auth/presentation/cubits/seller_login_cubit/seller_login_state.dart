part of 'seller_login_cubit.dart';

@immutable
sealed class SellerLoginState {}

final class SellerLoginInitial extends SellerLoginState {}

final class SellerLoginLoading extends SellerLoginState {}

final class SellerLoginSuccess extends SellerLoginState {
  final SellerEntity sellerEntity;

  SellerLoginSuccess(this.sellerEntity);
}

final class SellerLoginFailure extends SellerLoginState {
  final String errMessage;

  SellerLoginFailure(this.errMessage);
}
