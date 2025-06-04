part of 'seller_signup_cubit.dart';

@immutable
sealed class SellerSignupState {}

final class SellerSignupInitial extends SellerSignupState {}

final class SellerSignupLoading extends SellerSignupState {}

final class SellerSignupSuccess extends SellerSignupState {}

final class SellerSignupFailure extends SellerSignupState {
  final String errMessage;

  SellerSignupFailure(this.errMessage);
}
