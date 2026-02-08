import 'package:swift_mobile_app/features/client/order/domain/entities/order_item_entity.dart';

class OrderEntity {
  final String id;
  final String userId;
  final String address;
  final String state;
  final DateTime createdAt;
  final List<OrderItemEntity> items;
  final num totalAmount;

  const OrderEntity({
    required this.id,
    required this.userId,
    required this.address,
    required this.state,
    required this.createdAt,
    required this.items,
    required this.totalAmount,
  });
}
