import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift_mobile_app/features/client/order/domain/entities/order_entity.dart';
import 'package:swift_mobile_app/features/client/order/domain/repo/order_repo.dart';

part 'order_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final OrdersRepo ordersRepository;

  OrdersCubit({required this.ordersRepository}) : super(OrdersInitial());

  Future<void> loadUserOrders(String userId) async {
    emit(OrdersLoading());

    final result = await ordersRepository.getUserOrders(userId);

    result.fold(
      (failure) => emit(OrdersError(failure.message)),
      (orders) => emit(OrdersLoaded(orders)),
    );
  }

  Future<void> cancelOrder(String orderId) async {
    final result = await ordersRepository.cancelOrder(orderId);

    result.fold(
      (failure) => emit(OrdersError(failure.message)),
      (_) => emit(OrderCancelled()),
    );
  }
}
