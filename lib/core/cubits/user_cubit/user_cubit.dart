import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  void setUser(dynamic user) {
    emit(UserLoaded(user));
  }

  void clearUser() {
    emit(UserInitial());
  }

  dynamic get currentUser =>
      state is UserLoaded ? (state as UserLoaded).user : null;

  bool get isLoggedIn => state is UserLoaded;

  bool get isSeller => currentUser != null && currentUser.sellerId != null;

  bool get isClient => currentUser != null && currentUser.sellerId == null;
}
