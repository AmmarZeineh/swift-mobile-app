import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:swift_mobile_app/core/entities/product_entity.dart';
import 'package:swift_mobile_app/features/seller/home/domain/repos/seller_home_repo.dart';

part 'seller_fetch_products_state.dart';

class SellerFetchProductsCubit extends Cubit<FetchProductsState> {
  SellerFetchProductsCubit(this._sellerHomeRepo)
    : super(FetchProductsInitial());
  final SellerHomeRepo _sellerHomeRepo;

  Future<void> fetchProducts(int id) async {
    emit(FetchProductsLoading());
    var result = await _sellerHomeRepo.getProducts(id);
    result.fold(
      (l) => emit(FetchProductsFailure(l.message)),
      (products) => emit(FetchProductsSuccess(products)),
    );
  }
}
