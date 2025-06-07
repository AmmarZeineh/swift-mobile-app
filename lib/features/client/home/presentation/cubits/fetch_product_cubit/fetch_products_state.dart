part of 'fetch_products_cubit.dart';

@immutable
sealed class FetchProductsState {}

final class FetchProductsInitial extends FetchProductsState {}
final class FetchProductsLoading extends FetchProductsState {}
final class FetchProductsSuccess extends FetchProductsState {
  final List<ProductEntity> products;

  FetchProductsSuccess(this.products);
}
final class FetchProductsFailure extends FetchProductsState {
  final String errMessage;

  FetchProductsFailure(this.errMessage);
}  
