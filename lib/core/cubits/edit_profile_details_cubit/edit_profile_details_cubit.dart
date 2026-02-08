import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:swift_mobile_app/core/repos/profile_repo/profile_repo.dart';
import 'package:swift_mobile_app/features/seller/auth/domain/entity/seller_entity.dart';

part 'edit_profile_details_state.dart';

class EditProfileDetailsCubit extends Cubit<EditProfileDetailsState> {
  EditProfileDetailsCubit(this._sellerProfileRepo)
    : super(EditProfileDetailsInitial());
  final ProfileRepo _sellerProfileRepo;

  Future<void> editProfileDetails({
    required Map<String, dynamic> newData,
    required String columnName,
    required String columnValue,
  }) async {
    emit(EditProfileDetailsLoading());
    final result = await _sellerProfileRepo.editProfileDetails(
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
