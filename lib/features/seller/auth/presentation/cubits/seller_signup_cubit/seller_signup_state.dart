part of 'seller_signup_cubit.dart';

@immutable
 class SellerSignupState {}

 class SellerSignupInitial extends SellerSignupState {}

 class SellerSignupLoading extends SellerSignupState {}

 class SellerSignupSuccess extends SellerSignupState {}

 class SellerSignupFailure extends SellerSignupState {
  final String errMessage;

  SellerSignupFailure(this.errMessage);
}
