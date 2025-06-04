import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:swift_mobile_app/features/seller/auth/domain/entity/seller_entity.dart';
import 'package:swift_mobile_app/features/seller/auth/domain/repos/seller_auth_repo.dart';

part 'seller_login_state.dart';

class SellerLoginCubit extends Cubit<SellerLoginState> {
  SellerLoginCubit(this._sellerAuthRepo) : super(SellerLoginInitial());
  final SellerAuthRepo _sellerAuthRepo;

  Future<void> loginSeller(String email, String password) async {
    emit(SellerLoginLoading());
    final result = await _sellerAuthRepo.loginSeller(
      email: email,
      password: password,
    );
    result.fold(
      (l) {
        emit(SellerLoginFailure(l.message));
      },
      (sellerEntity) {
        emit(SellerLoginSuccess(sellerEntity));
      },
    );
  }
}
