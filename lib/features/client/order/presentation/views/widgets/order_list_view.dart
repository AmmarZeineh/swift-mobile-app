import 'package:flutter/widgets.dart';
import 'package:swift_mobile_app/features/client/order/domain/entities/order_entity.dart';
import 'package:swift_mobile_app/features/client/order/presentation/views/widgets/order_card.dart';

class OrdersListView extends StatelessWidget {
  const OrdersListView({super.key, required this.userId, required this.orders});

  final String userId;
  final List<OrderEntity> orders;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return OrderItem(order: order, userId: userId);
      },
    );
  }
}
