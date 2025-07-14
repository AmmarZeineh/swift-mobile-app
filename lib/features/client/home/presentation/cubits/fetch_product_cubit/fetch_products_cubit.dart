import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:swift_mobile_app/features/client/home/domain/entities/product_entity.dart';
import 'package:swift_mobile_app/features/client/home/domain/repos/home_repo.dart';
part 'fetch_products_state.dart';

class FetchProductsCubit extends Cubit<FetchProductsState> {
  FetchProductsCubit(this.homeRepo) : super(FetchProductsInitial());
  final HomeRepo homeRepo;
    int _page = 0;
  final int _limit = 10;
  bool _isLoadingMore = false;
  int? _currentCategoryId;
Future<void> fetchInitialProducts(int? categoryId) async {
    emit(FetchProductsLoading());
    _page = 0;
    _currentCategoryId = categoryId;
    final result = await homeRepo.fetchProducts(
      categoryId: categoryId,
      offset: 0,
      limit: _limit,
    );
    result.fold(
      (l) => emit(FetchProductsFailure(l.message)),
      (r) => emit(FetchProductsSuccess(
        products: r,
        hasMore: r.length == _limit,
      )),
    );
  }

  Future<void> loadMoreProducts() async {
    if (_isLoadingMore) return;
    _isLoadingMore = true;
    _page++;

    final result = await homeRepo.fetchProducts(
      categoryId: _currentCategoryId,
      offset: _page * _limit,
      limit: _limit,
    );

    final currentState = state;
    result.fold((l) {
      // ممكن تتجاهل الخطأ أو تعرض إشعار
    }, (newProducts) {
      if (currentState is FetchProductsSuccess) {
        final allProducts = [...currentState.products, ...newProducts];
        emit(FetchProductsSuccess(
          products: allProducts,
          hasMore: newProducts.length == _limit,
        ));
      }
    });

    _isLoadingMore = false;
  }
}

