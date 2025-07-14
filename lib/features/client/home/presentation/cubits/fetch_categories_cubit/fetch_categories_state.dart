part of 'fetch_categories_cubit.dart';

@immutable
 class FetchCategoriesState {}

 class FetchCategoriesInitial extends FetchCategoriesState {}

 class FetchCategoriesFailure extends FetchCategoriesState {
  final String errMessage;

  FetchCategoriesFailure(this.errMessage);
}

 class FetchCategoriesLoading extends FetchCategoriesState {}

 class FetchCategoriesSuccess extends FetchCategoriesState {
  final List<CategoryCardEntity> categories;

  FetchCategoriesSuccess(this.categories);
}
