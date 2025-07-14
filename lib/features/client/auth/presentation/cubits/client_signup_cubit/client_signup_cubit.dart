import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:swift_mobile_app/features/client/auth/domain/repos/client_auth_repo.dart';
part 'client_signup_state.dart';

class ClientSignupCubit extends Cubit<ClientSignupState> {
  ClientSignupCubit(this.clientAuthRepo) : super(ClientSignupInitial());
  final ClientAuthRepo clientAuthRepo;

  Future<void> signupClient(
    String email,
    String password,
    String userName,
    String phoneNumber,
    String gender,
    int age,
  ) async {
    emit(ClientSignupLoading());
    final result = await clientAuthRepo.signupClient(
      userName,
      email,
      password,
      phoneNumber,
      gender,
      age,
    );
    result.fold(
      (l) {
        emit(ClientSignupFailure(l.message));
      },
      (clientEntity) async {
        emit(ClientSignupSuccess());
      },
    );
  }
}