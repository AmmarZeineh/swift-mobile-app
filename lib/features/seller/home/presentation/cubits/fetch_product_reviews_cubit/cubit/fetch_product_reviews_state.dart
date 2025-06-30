part of 'fetch_product_reviews_cubit.dart';

sealed class FetchProductReviewsState extends Equatable {
  const FetchProductReviewsState();

  @override
  List<Object> get props => [];
}

final class FetchProductReviewsInitial extends FetchProductReviewsState {}

final class FetchProductReviewsLoading extends FetchProductReviewsState {}

final class FetchProductReviewsSuccess extends FetchProductReviewsState {
  final List<ReviewEntity> reviews;

  const FetchProductReviewsSuccess(this.reviews);
}

final class FetchProductReviewsFailure extends FetchProductReviewsState {
  final String errMessage;

  const FetchProductReviewsFailure(this.errMessage);
}
