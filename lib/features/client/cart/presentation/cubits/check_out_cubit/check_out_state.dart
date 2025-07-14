part of 'check_out_cubit.dart';
@immutable
 class CheckOutState {}

 class CheckOutInitial extends CheckOutState {}
 class CheckOutLoading extends CheckOutState {}
 class CheckOutSuccess extends CheckOutState {}
 class CheckOutFailure extends CheckOutState {
  final String message;
  CheckOutFailure(this.message);
}



