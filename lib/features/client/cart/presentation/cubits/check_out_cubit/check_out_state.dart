part of 'check_out_cubit.dart';
@immutable
sealed class CheckOutState {}

final class CheckOutInitial extends CheckOutState {}
final class CheckOutLoading extends CheckOutState {}
final class CheckOutSuccess extends CheckOutState {}
final class CheckOutFailure extends CheckOutState {
  final String message;
  CheckOutFailure(this.message);
}



