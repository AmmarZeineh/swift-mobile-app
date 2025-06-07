import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:swift_mobile_app/features/client/home/domain/entities/product_entity.dart';
import 'package:swift_mobile_app/features/client/home/domain/repos/home_repo.dart';
part 'fetch_products_state.dart';

class FetchProductsCubit extends Cubit<FetchProductsState> {
  FetchProductsCubit(this.homeRepo) : super(FetchProductsInitial());
  final HomeRepo homeRepo;
  Future<void> fetchProducts() async {
    emit(FetchProductsLoading());
    var result = await homeRepo.fetchProducts();
    result.fold(
      (l) => emit(FetchProductsFailure(l.message)),
      (r) => emit(FetchProductsSuccess(r)),
    );
  }
}
