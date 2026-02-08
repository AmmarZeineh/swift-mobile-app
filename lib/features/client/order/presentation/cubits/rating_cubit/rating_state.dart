part of 'rating_cubit.dart';

class RatingState extends Equatable {
  const RatingState();

  @override
  List<Object> get props => [];
}

class RatingInitial extends RatingState {}

class RatingFailure extends RatingState {
  final String errMessage;

  const RatingFailure(this.errMessage);
}

class RatingSuccess extends RatingState {}

class RatingLoading extends RatingState {}
