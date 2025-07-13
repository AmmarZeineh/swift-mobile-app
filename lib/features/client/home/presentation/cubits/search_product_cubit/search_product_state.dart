part of 'search_product_cubit.dart';


abstract class SearchProductState {}

class SearchInitial extends SearchProductState {}

class SearchLoading extends SearchProductState {}

class SearchLoaded extends SearchProductState {
  final List<ProductEntity> products;

  SearchLoaded(this.products);
}

class SearchError extends SearchProductState {
  final String message;

  SearchError(this.message);
}
