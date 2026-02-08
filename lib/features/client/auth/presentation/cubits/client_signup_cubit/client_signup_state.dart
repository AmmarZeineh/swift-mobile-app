part of 'client_signup_cubit.dart';

@immutable
class ClientSignupState {}

class ClientSignupInitial extends ClientSignupState {}

class ClientSignupLoading extends ClientSignupState {}

class ClientSignupSuccess extends ClientSignupState {}

class ClientSignupFailure extends ClientSignupState {
  final String errMessage;

  ClientSignupFailure(this.errMessage);
}
