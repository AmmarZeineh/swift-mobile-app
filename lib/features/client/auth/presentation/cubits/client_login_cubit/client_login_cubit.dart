import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:swift_mobile_app/features/client/auth/domain/entities/client_entity.dart';
import 'package:swift_mobile_app/features/client/auth/domain/repos/client_auth_repo.dart';

part 'client_login_state.dart';

class ClientLoginCubit extends Cubit<ClientLoginState> {
  ClientLoginCubit(this._clientAuthRepo) : super(ClientLoginInitial());
  final ClientAuthRepo _clientAuthRepo;
  late ClientEntity clientEntity1;

  Future<void> loginClient(String email, String password,BuildContext context) async {
    emit(ClientLoginLoading());
    final result = await _clientAuthRepo.loginClient(
      email: email,
      password: password,
      context: context
    );
    result.fold(
      (l) {
        emit(ClientLoginFailure(l.message));
      },
      (clientEntity) {
        clientEntity1 = clientEntity;

        emit(ClientLoginSuccess(clientEntity));
      },
    );
  }
}
