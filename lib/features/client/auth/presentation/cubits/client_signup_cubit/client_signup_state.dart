part of 'client_signup_cubit.dart';

@immutable
sealed class ClientSignupState {}

final class ClientSignupInitial extends ClientSignupState {}

final class ClientSignupLoading extends ClientSignupState {}

final class ClientSignupSuccess extends ClientSignupState {}

final class ClientSignupFailure extends ClientSignupState {
  final String errMessage;

  ClientSignupFailure(this.errMessage);
}
