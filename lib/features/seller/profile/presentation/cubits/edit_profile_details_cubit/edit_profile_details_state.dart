part of 'edit_profile_details_cubit.dart';

sealed class EditProfileDetailsState extends Equatable {
  const EditProfileDetailsState();

  @override
  List<Object> get props => [];
}

final class EditProfileDetailsInitial extends EditProfileDetailsState {}

final class EditProfileDetailsLoading extends EditProfileDetailsState {}

final class EditProfileDetailsFailure extends EditProfileDetailsState {
  final String errMessage;

  const EditProfileDetailsFailure(this.errMessage);
}

final class EditProfileDetailsSuccess extends EditProfileDetailsState {}
