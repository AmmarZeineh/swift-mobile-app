part of 'fetch_products_cubit.dart';

sealed class FetchProductsState extends Equatable {
  const FetchProductsState();

  @override
  List<Object> get props => [];
}

final class FetchProductsInitial extends FetchProductsState {}

final class FetchProductsLoading extends FetchProductsState {}

final class FetchProductsSuccess extends FetchProductsState {
  final List<ProductEntity> products;

  const FetchProductsSuccess(this.products);
}

final class FetchProductsFailure extends FetchProductsState {
  final String errMessage;

  const FetchProductsFailure(this.errMessage);
}
