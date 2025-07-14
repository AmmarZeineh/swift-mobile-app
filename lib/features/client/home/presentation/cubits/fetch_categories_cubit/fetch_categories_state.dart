part of 'fetch_categories_cubit.dart';

@immutable
sealed class FetchCategoriesState {}

final class FetchCategoriesInitial extends FetchCategoriesState {}

final class FetchCategoriesFailure extends FetchCategoriesState {
  final String errMessage;

  FetchCategoriesFailure(this.errMessage);
}

final class FetchCategoriesLoading extends FetchCategoriesState {}

final class FetchCategoriesSuccess extends FetchCategoriesState {
  final List<CategoryCardEntity> categories;

  FetchCategoriesSuccess(this.categories);
}
