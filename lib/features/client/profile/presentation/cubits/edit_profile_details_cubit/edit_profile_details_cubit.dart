import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:swift_mobile_app/features/client/auth/domain/entities/client_entity.dart';
import 'package:swift_mobile_app/features/client/profile/domain/repos/client_profile_repo.dart';

part 'edit_profile_details_state.dart';

class EditProfileDetailsCubit extends Cubit<EditProfileDetailsState> {
  EditProfileDetailsCubit(this._clientProfileRepo)
    : super(EditProfileDetailsInitial());
  final CLientProfileRepo _clientProfileRepo;

  Future<void> editProfileDetails({
    required ClientEntity clientEntity,
    required Map<String, dynamic> newData,
    required String columnName,
    required String columnValue,
  }) async {
    emit(EditProfileDetailsLoading());
    final result = await _clientProfileRepo.editProfileDetails(
      clientEntity,
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
}
