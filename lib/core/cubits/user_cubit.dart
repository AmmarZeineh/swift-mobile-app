import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:swift_mobile_app/features/seller/auth/domain/entity/seller_entity.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  void setUser(SellerEntity user) {
    emit(UserLoaded(user));
  }

  void clearUser() {
    emit(UserInitial());
  }

  SellerEntity? get currentUser =>
      state is UserLoaded ? (state as UserLoaded).user : null;

  bool get isLoggedIn => state is UserLoaded;
}
