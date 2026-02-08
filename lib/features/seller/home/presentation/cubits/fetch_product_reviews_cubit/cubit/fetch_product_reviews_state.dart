part of 'fetch_product_reviews_cubit.dart';

 class FetchProductReviewsState extends Equatable {
  const FetchProductReviewsState();

  @override
  List<Object> get props => [];
}

 class FetchProductReviewsInitial extends FetchProductReviewsState {}

 class FetchProductReviewsLoading extends FetchProductReviewsState {}

 class FetchProductReviewsSuccess extends FetchProductReviewsState {
  final List<ReviewEntity> reviews;

  const FetchProductReviewsSuccess(this.reviews);
}

 class FetchProductReviewsFailure extends FetchProductReviewsState {
  final String errMessage;

  const FetchProductReviewsFailure(this.errMessage);
}
