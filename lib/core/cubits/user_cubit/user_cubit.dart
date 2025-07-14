import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift_mobile_app/features/client/auth/domain/entities/client_entity.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  void setUser(ClientEntity user) {
    emit(UserLoaded(user));
  }

  void clearUser() {
    emit(UserInitial());
  }

  ClientEntity? get currentUser =>
      state is UserLoaded ? (state as UserLoaded).user : null;

  bool get isLoggedIn => state is UserLoaded;
}