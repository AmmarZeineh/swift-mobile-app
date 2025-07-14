import 'package:bloc/bloc.dart';
import 'package:swift_mobile_app/features/client/home/domain/entities/product_entity.dart';
import 'package:swift_mobile_app/features/client/home/domain/repos/home_repo.dart';

part 'search_product_state.dart';

class SearchProductCubit extends Cubit<SearchProductState> {
  final HomeRepo homeRepo;
  SearchProductCubit(this.homeRepo) : super(SearchInitial());
  Future<void> searchProducts({
    required String keyword,
    int? categoryId,
  }) async {
    emit(SearchLoading());

    final result = await homeRepo.searchProducts(
      keyword: keyword,
      categoryId: categoryId,
    );

    result.fold(
      (failure) => emit(SearchError(failure.message)),
      (products) => emit(SearchLoaded(products)),
    );
  }
}
