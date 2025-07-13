import 'package:flutter/material.dart';
import 'package:swift_mobile_app/features/client/order/domain/entities/order_entity.dart';
import 'package:swift_mobile_app/features/client/order/domain/entities/order_item_entity.dart';
import 'package:swift_mobile_app/features/client/order/presentation/views/widgets/order_item_view_body.dart';

class OrderItemsView extends StatelessWidget {
  const OrderItemsView({super.key, required this.items, required this.orderEntity});
  static const String routeName = "order_item_view";
  final List<OrderItemEntity> items;
  final OrderEntity orderEntity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: OrderItemViewBody(items: items, orderEntity: orderEntity,)));
  }
}
