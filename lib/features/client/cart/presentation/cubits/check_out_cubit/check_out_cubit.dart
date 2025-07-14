import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:swift_mobile_app/features/client/cart/domain/repos/cart_repo.dart';

part 'check_out_state.dart';

class CheckOutCubit extends Cubit<CheckOutState> {
  CheckOutCubit(this.cartRepo) : super(CheckOutInitial());
  final CartRepo cartRepo;

  Future<void> addOrder({
    required String userId,
    required String address,
    String state = 'معلق',
  }) async {
    emit(CheckOutLoading());
    final result = await cartRepo.addOrder(
      userId: userId,
      address: address,
      state: state,
    );
    result.fold(
      (l) => emit(CheckOutFailure(l.message)),
      (r) => emit(CheckOutSuccess()),
    );
  }
}
