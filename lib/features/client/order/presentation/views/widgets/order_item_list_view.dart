import 'package:flutter/material.dart';
import 'package:swift_mobile_app/features/client/order/domain/entities/order_entity.dart';
import 'package:swift_mobile_app/features/client/order/domain/entities/order_item_entity.dart';
import 'package:swift_mobile_app/features/client/order/presentation/views/widgets/custom_order_item.dart';

class OrderItemsListView extends StatelessWidget {
  const OrderItemsListView({super.key, required this.items, required this.orderEntity});
  final List<OrderItemEntity> items;
  final OrderEntity orderEntity;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (_, index) {
          return CustomOrderItem(
            orderItemEntity: items[index],
            isOrderCompleted: orderEntity.state.toLowerCase() == 'completed',
          );
        },
      ),
    );
  }
}
