part of 'fetch_categories_cubit.dart';

 class FetchCategoriesState extends Equatable {
  const FetchCategoriesState();

  @override
  List<Object> get props => [];
}

 class FetchCategoriesInitial extends FetchCategoriesState {}

 class FetchCategoriesLoading extends FetchCategoriesState {}

 class FetchCategoriesFailure extends FetchCategoriesState {
  final String errMessage;

  const FetchCategoriesFailure(this.errMessage);
}

 class FetchCategoriesSuccess extends FetchCategoriesState {
  final List<CategoryEntity> categories;

  const FetchCategoriesSuccess(this.categories);
}
