import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:swift_mobile_app/features/client/product_details/domain/repo/product_details_repo.dart';

import '../../../../../../core/entities/product_entity.dart';

part 'add_to_cart_state.dart';

class AddToCartCubit extends Cubit<AddToCartState> {
  AddToCartCubit(this.repository) : super(AddToCartInitial());
  final ProductDetailsRepo repository;
  Future<void> addToCart({
    required dynamic userId,
    required ProductEntity product,
    required int quantity,
    required String selectedAttributesSummary,
  }) async {
    emit(AddToCartLoading());
    var result = await repository.addToCart(
      userId,
      product.id,
      quantity,
      product.price.toDouble(),
      selectedAttributesSummary,
    );
    result.fold(
      (l) => emit(AddToCartFailure(l.message)),
      (r) => emit(AddToCartSuccess(product)),
    );
  }
}
