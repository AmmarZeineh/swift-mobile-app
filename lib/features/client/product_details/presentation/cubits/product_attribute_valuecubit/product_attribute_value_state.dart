part of 'product_attribute_value_cubit.dart';

@immutable
sealed class ProductAttributesState {}

final class ProductAttributesInitial extends ProductAttributesState {}

final class ProductAttributesLoading extends ProductAttributesState {}

final class ProductAttributesFailure extends ProductAttributesState {
  final String errMessage;

  ProductAttributesFailure(this.errMessage);
}

final class ProductAttributesSuccess extends ProductAttributesState {
  final List<ProductAttributeWithValues> attributesWithValues;

  ProductAttributesSuccess(this.attributesWithValues);
}