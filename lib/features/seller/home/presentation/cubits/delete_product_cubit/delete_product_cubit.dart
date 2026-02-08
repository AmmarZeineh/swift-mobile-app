import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:swift_mobile_app/core/repos/image_repo/image_repo.dart';
import 'package:swift_mobile_app/features/seller/home/domain/repos/seller_home_repo.dart';

part 'delete_product_state.dart';

class DeleteProductCubit extends Cubit<DeleteProductState> {
  DeleteProductCubit(this._sellerHomeRepo, this._imageRepo)
    : super(DeleteProductInitial());
  final SellerHomeRepo _sellerHomeRepo;
  final ImageRepo _imageRepo;

  Future<void> deleteProduct(int id) async {
    emit(DeleteProductLoading());
    final result = await _sellerHomeRepo.deleteProduct(id);
    result.fold(
      (l) => emit(DeleteProductFailure(l.message)),
      (r) => emit(DeleteProductSuccess()),
    );
  }

  Future<void> deleteProductImage(List<String> urls) async {
    emit(DeleteProductLoading());
    final result = await _imageRepo.deleteImages(urls, 'product.images');
    result.fold(
      (l) => emit(DeleteProductFailure(l.message)),
      (r) => emit(DeleteProductSuccess()),
    );
  }
}
