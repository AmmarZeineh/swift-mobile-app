import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:swift_mobile_app/features/seller/add_product/domain/entities/category_entity.dart';
import 'package:swift_mobile_app/features/seller/add_product/domain/repos/add_product_repo.dart';

part 'fetch_categories_state.dart';

class FetchCategoriesCubit extends Cubit<FetchCategoriesState> {
  FetchCategoriesCubit(this._addProductRepo) : super(FetchCategoriesInitial());
  final AddProductRepo _addProductRepo;

  Future<void> fetchCategories() async {
    emit(FetchCategoriesLoading());
    final result = await _addProductRepo.fetchCategories();
    result.fold(
      (failure) => emit(FetchCategoriesFailure(failure.message)),
      (categories) => emit(FetchCategoriesSuccess(categories)),
    );
  }
}
