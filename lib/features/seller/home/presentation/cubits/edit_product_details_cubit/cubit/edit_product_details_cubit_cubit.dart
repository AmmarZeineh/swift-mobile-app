import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:swift_mobile_app/core/entities/product_entity.dart';
import 'package:swift_mobile_app/features/seller/home/domain/repos/seller_home_repo.dart';

part 'edit_product_details_cubit_state.dart';

class EditProductDetailsCubitCubit extends Cubit<EditProductDetailsCubitState> {
  EditProductDetailsCubitCubit(this._sellerHomeRepo)
    : super(EditProductDetailsCubitInitial());

  final SellerHomeRepo _sellerHomeRepo;

  Future<void> updateProduct(
    ProductEntity product,
    Map<String, dynamic> newData,
  ) async {
    emit(EditProductDetailsCubitLoading());
    var result = await _sellerHomeRepo.editProductDetails(
      'id',
      product.id.toString(),
      newData,
    );
    result.fold(
      (l) => emit(EditProductDetailsCubitFailure(l.message)),
      (r) => emit(
        EditProductDetailsCubitSuccess(
          product.copyWith(
            name: newData['name'] ?? product.name,
            description: newData['description'] ?? product.description,
            price: newData['price'] ?? product.price,
            stock: newData['stock'] ?? product.stock,
          ),
        ),
      ),
    );
  }

  Future<void> editProductAttribute(
    ProductEntity productEntity,
    String attributeId,
    String valueId,
    String newValue,
  ) async {
    emit(EditProductDetailsCubitLoading());
    var result = await _sellerHomeRepo.editAttributeValue(
      productEntity.id.toString(),
      int.parse(attributeId),
      int.parse(valueId),
      newValue,
    );
    result.fold(
      (l) => emit(EditProductDetailsCubitFailure(l.message)),
      (r) => emit(EditProductDetailsCubitSuccess(productEntity)),
    );
  }

  Future<void> deleteProductAttribute(
    ProductEntity productEntity,
    String attributeId,
    String valueId,
  ) async {
    emit(EditProductDetailsCubitLoading());

    var result = await _sellerHomeRepo.deleteAttributeValue(
      productEntity.id.toString(),
      int.parse(attributeId),
      int.parse(valueId),
    );
    result.fold(
      (l) => emit(EditProductDetailsCubitFailure(l.message)),
      (r) => emit(EditProductDetailsCubitSuccess(productEntity)),
    );
  }

  Future<void> addAttributeValue(
    ProductEntity productEntity,
    String attributeId,
    String newValue,
  ) async {
    emit(EditProductDetailsCubitLoading());

    var result = await _sellerHomeRepo.addAttributeValue(
      productEntity.id.toString(),
      int.parse(attributeId),
      newValue,
    );
    result.fold(
      (l) => emit(EditProductDetailsCubitFailure(l.message)),
      (r) => emit(EditProductDetailsCubitSuccess(productEntity)),
    );
  }
}
