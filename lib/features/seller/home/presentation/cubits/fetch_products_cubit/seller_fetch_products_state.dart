part of 'seller_fetch_products_cubit.dart';



class FetchProductsState extends Equatable {
  const FetchProductsState();

  @override
  List<Object> get props => [];
}

 class FetchProductsInitial extends FetchProductsState {}

 class FetchProductsLoading extends FetchProductsState {}

 class FetchProductsSuccess extends FetchProductsState {
  final List<ProductEntity> products;

  const FetchProductsSuccess(this.products);
}

 class FetchProductsFailure extends FetchProductsState {
  final String errMessage;

  const FetchProductsFailure(this.errMessage);
}
