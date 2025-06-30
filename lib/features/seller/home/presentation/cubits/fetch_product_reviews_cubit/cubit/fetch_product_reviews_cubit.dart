import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:swift_mobile_app/features/seller/home/domain/entities/product_entity.dart';
import 'package:swift_mobile_app/features/seller/home/domain/entities/review_entity.dart';
import 'package:swift_mobile_app/features/seller/home/domain/repos/seller_home_repo.dart';

part 'fetch_product_reviews_state.dart';

class FetchProductReviewsCubit extends Cubit<FetchProductReviewsState> {
  FetchProductReviewsCubit(this._sellerHomeRepo)
    : super(FetchProductReviewsInitial());
  final SellerHomeRepo _sellerHomeRepo;

  Future<void> fetchProductReviews(ProductEntity productEntity) async {
    emit(FetchProductReviewsLoading());
    final result = await _sellerHomeRepo.getProductReviews(productEntity);
    result.fold(
      (l) => emit(FetchProductReviewsFailure(l.message)),
      (r) => emit(FetchProductReviewsSuccess(r)),
    );
  }
}
