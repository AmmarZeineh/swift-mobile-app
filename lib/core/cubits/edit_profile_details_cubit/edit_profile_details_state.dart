part of 'edit_profile_details_cubit.dart';

 class EditProfileDetailsState extends Equatable {
  const EditProfileDetailsState();

  @override
  List<Object> get props => [];
}

 class EditProfileDetailsInitial extends EditProfileDetailsState {}

 class EditProfileDetailsLoading extends EditProfileDetailsState {}

 class EditProfileDetailsFailure extends EditProfileDetailsState {
  final String errMessage;

  const EditProfileDetailsFailure(this.errMessage);
}

 class EditProfileDetailsSuccess extends EditProfileDetailsState {}
