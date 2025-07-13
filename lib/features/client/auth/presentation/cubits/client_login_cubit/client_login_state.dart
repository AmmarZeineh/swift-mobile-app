part of 'client_login_cubit.dart';

@immutable
sealed class ClientLoginState {}

final class ClientLoginInitial extends ClientLoginState {}

final class ClientLoginLoading extends ClientLoginState {}

final class ClientLoginSuccess extends ClientLoginState {
  final ClientEntity clientEntity;

  ClientLoginSuccess(this.clientEntity);
}

final class ClientLoginFailure extends ClientLoginState {
  final String errMessage;

  ClientLoginFailure(this.errMessage);
}
