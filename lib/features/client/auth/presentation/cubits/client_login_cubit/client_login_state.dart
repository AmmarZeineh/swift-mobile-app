part of 'client_login_cubit.dart';

@immutable
 class ClientLoginState {}

 class ClientLoginInitial extends ClientLoginState {}

 class ClientLoginLoading extends ClientLoginState {}

 class ClientLoginSuccess extends ClientLoginState {
  final ClientEntity clientEntity;

  ClientLoginSuccess(this.clientEntity);
}

 class ClientLoginFailure extends ClientLoginState {
  final String errMessage;

  ClientLoginFailure(this.errMessage);
}
