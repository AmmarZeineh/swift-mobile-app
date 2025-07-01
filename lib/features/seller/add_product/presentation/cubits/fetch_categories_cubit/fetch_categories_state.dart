part of 'fetch_categories_cubit.dart';

sealed class FetchCategoriesState extends Equatable {
  const FetchCategoriesState();

  @override
  List<Object> get props => [];
}

final class FetchCategoriesInitial extends FetchCategoriesState {}

final class FetchCategoriesLoading extends FetchCategoriesState {}

final class FetchCategoriesFailure extends FetchCategoriesState {
  final String errMessage;

  const FetchCategoriesFailure(this.errMessage);
}

final class FetchCategoriesSuccess extends FetchCategoriesState {
  final List<CategoryEntity> categories;

  const FetchCategoriesSuccess(this.categories);
}
