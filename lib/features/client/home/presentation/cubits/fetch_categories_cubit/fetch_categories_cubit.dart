import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:swift_mobile_app/features/client/home/domain/entities/category_card_entity.dart';
import 'package:swift_mobile_app/features/client/home/domain/repos/home_repo.dart';

part 'fetch_categories_state.dart';

class FetchCategoriesCubit extends Cubit<FetchCategoriesState> {
  FetchCategoriesCubit(this.homeRepo) : super(FetchCategoriesInitial());
  final HomeRepo homeRepo;
  Future<void> fetchCategories() async {
    emit(FetchCategoriesLoading());
    var result = await homeRepo.fetchCategories();
    result.fold(
      (l) => emit(FetchCategoriesFailure(l.message)),
      (r) => emit(FetchCategoriesSuccess(r)),
    );
  }
}
