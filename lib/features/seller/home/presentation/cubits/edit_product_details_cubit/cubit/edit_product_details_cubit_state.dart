part of 'edit_product_details_cubit_cubit.dart';

sealed class EditProductDetailsCubitState extends Equatable {
  const EditProductDetailsCubitState();

  @override
  List<Object> get props => [];
}

final class EditProductDetailsCubitInitial
    extends EditProductDetailsCubitState {}

final class EditProductDetailsCubitLoading
    extends EditProductDetailsCubitState {}

final class EditProductDetailsCubitFailure
    extends EditProductDetailsCubitState {
  final String errMessage;

  const EditProductDetailsCubitFailure(this.errMessage);
}

final class EditProductDetailsCubitSuccess
    extends EditProductDetailsCubitState {
  final ProductEntity productEntity;

  const EditProductDetailsCubitSuccess(this.productEntity);
}
