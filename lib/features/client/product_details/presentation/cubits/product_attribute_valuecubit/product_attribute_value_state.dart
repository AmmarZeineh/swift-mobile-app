part of 'product_attribute_value_cubit.dart';

@immutable
 class ProductAttributesState {}

 class ProductAttributesInitial extends ProductAttributesState {}

 class ProductAttributesLoading extends ProductAttributesState {}

 class ProductAttributesFailure extends ProductAttributesState {
  final String errMessage;

  ProductAttributesFailure(this.errMessage);
}

 class ProductAttributesSuccess extends ProductAttributesState {
  final List<ProductAttributeWithValues> attributesWithValues;

  ProductAttributesSuccess(this.attributesWithValues);
}