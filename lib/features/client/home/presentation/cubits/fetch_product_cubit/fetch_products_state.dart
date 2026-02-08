part of 'fetch_products_cubit.dart';

@immutable
 class FetchProductsState {}

 class FetchProductsInitial extends FetchProductsState {}
 class FetchProductsLoading extends FetchProductsState {}
 class FetchProductsSuccess extends FetchProductsState {
  final List<ProductEntity> products;
  final bool hasMore;

  FetchProductsSuccess({required this.products, required this.hasMore});
}
 class FetchProductsFailure extends FetchProductsState {
  final String errMessage;

  FetchProductsFailure(this.errMessage);
}  
