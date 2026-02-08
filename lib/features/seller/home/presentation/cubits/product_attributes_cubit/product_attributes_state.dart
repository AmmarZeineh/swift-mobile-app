part of 'product_attributes_cubit.dart';

abstract class ProductAttributesState extends Equatable {
  const ProductAttributesState();

  @override
  List<Object> get props => [];
}

class ProductAttributesInitial extends ProductAttributesState {}

class ProductAttributesLoading extends ProductAttributesState {}

class ProductAttributesSuccess extends ProductAttributesState {
  final List<ProductAttributeWithValues> data;

  const ProductAttributesSuccess(this.data);

  @override
  List<Object> get props => [data];
}

class ProductAttributesFailure extends ProductAttributesState {
  final String errMessage;

  const ProductAttributesFailure(this.errMessage);

  @override
  List<Object> get props => [errMessage];
}
