part of 'rating_cubit.dart';

sealed class RatingState extends Equatable {
  const RatingState();

  @override
  List<Object> get props => [];
}

final class RatingInitial extends RatingState {}

final class RatingFailure extends RatingState {
  final String errMessage;

  const RatingFailure(this.errMessage);
}

final class RatingSuccess extends RatingState {}

final class RatingLoading extends RatingState {}
