import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:swift_mobile_app/core/entities/product_entity.dart';
import 'package:swift_mobile_app/features/seller/add_product/domain/repos/add_product_repo.dart';

part 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  AddProductCubit(this._addProductRepo) : super(AddProductInitial());
  final AddProductRepo _addProductRepo;

  Future<void> addProduct(
    List<File> images,
    ProductEntity productEntity,
    int sellerId
  ) async {
    emit(AddProductLoading());
    final result = await _addProductRepo.addProduct(images, productEntity,sellerId);
    result.fold(
      (failure) => emit(AddProductFailure(failure.message)),
      (_) => emit(AddProductSuccess()),
    );
  }
}
