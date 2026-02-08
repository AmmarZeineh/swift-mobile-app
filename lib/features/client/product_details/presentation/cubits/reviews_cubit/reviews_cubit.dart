
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift_mobile_app/core/entities/review_entity.dart';
import 'package:swift_mobile_app/features/client/product_details/domain/repo/product_details_repo.dart';

part 'reviews_state.dart';

class ReviewsCubit extends Cubit<ReviewsState> {
  final ProductDetailsRepo repository;

  ReviewsCubit(this.repository) : super(ReviewsInitial());

  Future<void> fetchReviews(int productId) async {
    emit(ReviewsLoading());
    final result = await repository.fetchReviewsForProduct(productId);

    result.fold(
      (failure) => emit(ReviewsError(failure.message)),
      (reviews) => emit(ReviewsLoaded(reviews)),
    );
  }
}
