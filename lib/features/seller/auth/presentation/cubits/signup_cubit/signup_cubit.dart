import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:swift_mobile_app/core/repos/image_repo/image_repo.dart';
import 'package:swift_mobile_app/features/seller/auth/domain/repos/seller_auth_repo.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit(this.sellerAuthRepo, this.imageRepo) : super(SignupInitial());
  final SellerAuthRepo sellerAuthRepo;
  final ImageRepo imageRepo;

  Future<void> signupSeller(
    String email,
    String password,
    String userName,
    String phoneNumber,
    String storeName,
    String storeAddress,
    File image,
  ) async {
    emit(SignupLoading());
    final result = await sellerAuthRepo.signupSeller(
      userName,
      email,
      password,
      phoneNumber,
      storeName,
      storeAddress,
      image,
    );
    result.fold(
      (l) {
        emit(SignupFailure(l.message));
      },
      (sellerEntity) async {
        emit(SignupSuccess());
      },
    );
  }
}
