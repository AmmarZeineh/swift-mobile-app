import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:swift_mobile_app/core/repos/image_repo/image_repo.dart';
import 'package:swift_mobile_app/features/seller/auth/domain/repos/seller_auth_repo.dart';

part 'seller_signup_state.dart';

class SellerSignupCubit extends Cubit<SellerSignupState> {
  SellerSignupCubit(this.sellerAuthRepo, this.imageRepo)
    : super(SellerSignupInitial());
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
    emit(SellerSignupLoading());
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
        emit(SellerSignupFailure(l.message));
      },
      (sellerEntity) async {
        emit(SellerSignupSuccess());
      },
    );
  }
}
