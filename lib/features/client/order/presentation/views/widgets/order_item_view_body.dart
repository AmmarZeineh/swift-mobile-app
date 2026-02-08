import 'package:flutter/material.dart';
import 'package:swift_mobile_app/core/widgets/secondry_custom_app_bar.dart';
import 'package:swift_mobile_app/features/client/order/domain/entities/order_entity.dart';
import 'package:swift_mobile_app/features/client/order/domain/entities/order_item_entity.dart';
import 'package:swift_mobile_app/features/client/order/presentation/views/widgets/order_item_list_view.dart';

class OrderItemViewBody extends StatelessWidget {
  const OrderItemViewBody({
    super.key,
    required this.items,
    required this.orderEntity,
  });
  final List<OrderItemEntity> items;
  final OrderEntity orderEntity;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(text: "تفاصيل ", isArrowActive: false),
        SizedBox(height: 8),
        OrderItemsListView(items: items, orderEntity: orderEntity),
      ],
    );
  }
}
