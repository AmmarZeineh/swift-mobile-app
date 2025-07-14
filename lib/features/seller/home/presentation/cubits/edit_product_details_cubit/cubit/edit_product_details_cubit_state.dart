part of 'edit_product_details_cubit_cubit.dart';

 class EditProductDetailsCubitState extends Equatable {
  const EditProductDetailsCubitState();

  @override
  List<Object> get props => [];
}

 class EditProductDetailsCubitInitial
    extends EditProductDetailsCubitState {}

 class EditProductDetailsCubitLoading
    extends EditProductDetailsCubitState {}

 class EditProductDetailsCubitFailure
    extends EditProductDetailsCubitState {
  final String errMessage;

  const EditProductDetailsCubitFailure(this.errMessage);
}

 class EditProductDetailsCubitSuccess
    extends EditProductDetailsCubitState {
  final ProductEntity productEntity;

  const EditProductDetailsCubitSuccess(this.productEntity);
}
