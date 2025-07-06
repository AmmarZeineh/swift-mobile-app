import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:swift_mobile_app/features/seller/auth/domain/entity/seller_entity.dart';
import 'package:swift_mobile_app/features/seller/profile/domain/repos/seller_profile_repo.dart';

part 'edit_profile_details_state.dart';

class EditProfileDetailsCubit extends Cubit<EditProfileDetailsState> {
  EditProfileDetailsCubit(this._sellerProfileRepo)
    : super(EditProfileDetailsInitial());
  final SellerProfileRepo _sellerProfileRepo;

  Future<void> editProfileDetails({
    required SellerEntity sellerEntity,
    required Map<String, dynamic> newData,
    required String columnName,
    required String columnValue,
  }) async {
    emit(EditProfileDetailsLoading());
    final result = await _sellerProfileRepo.editProfileDetails(
      sellerEntity,
      newData,
      columnName,
      columnValue,
    );
    result.fold(
      (l) {
        emit(EditProfileDetailsFailure(l.message));
      },
      (r) {
        emit(EditProfileDetailsSuccess());
      },
    );
  }

  Future<void> editSellerDetails({
    required SellerEntity sellerEntity,
    required Map<String, dynamic> newData,
    required String columnName,
    required String columnValue,
  }) async {
    emit(EditProfileDetailsLoading());
    final result = await _sellerProfileRepo.editSellerDetails(
      sellerEntity,
      newData,
      columnName,
      columnValue,
    );
    result.fold(
      (l) => emit(EditProfileDetailsFailure(l.message)),
      (r) => emit(EditProfileDetailsSuccess()),
    );
  }
}
