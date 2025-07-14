import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:swift_mobile_app/core/entites/review_entity.dart';
import 'package:swift_mobile_app/features/client/auth/domain/entities/client_entity.dart';
import 'package:swift_mobile_app/features/client/order/domain/repo/order_repo.dart';

part 'rating_state.dart';

class RatingCubit extends Cubit<RatingState> {
  RatingCubit(this._ordersRepo) : super(RatingInitial());

  final OrdersRepo _ordersRepo;

  Future<void> rateProduct(
    ClientEntity clientEntity,
    ReviewEntity review,
  ) async {
    emit(RatingLoading());
    var result = await _ordersRepo.rateProduct(clientEntity, review);

    result.fold(
      (l) => emit(RatingFailure(l.message)),
      (r) => emit(RatingSuccess()),
    );
  }
}
