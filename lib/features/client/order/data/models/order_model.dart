
import 'package:swift_mobile_app/features/client/order/data/models/order_item_model.dart';
import 'package:swift_mobile_app/features/client/order/domain/entities/order_entity.dart';

class OrderModel extends OrderEntity {
  const OrderModel({
    required super.id,
    required super.userId,
    required super.address,
    required super.state,
    required super.createdAt,
    required super.items,
    required super.totalAmount,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'].toString(),
      userId: json['user_id'].toString(),
      address: json['address'] ?? '',
      state: json['state'] ?? 'pending',
      createdAt: DateTime.parse(json['created_at']),
      items:
          (json['order_items'] as List<dynamic>?)
              ?.map((item) => OrderItemModel.fromJson(item))
              .toList() ??
          [],
      totalAmount: _calculateTotalAmount(json['order_items']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'address': address,
      'state': state,
      'created_at': createdAt.toIso8601String(),
      'order_items':
          items.map((item) => (item as OrderItemModel).toJson()).toList(),
    };
  }

  static double _calculateTotalAmount(List<dynamic>? items) {
    if (items == null || items.isEmpty) return 0.0;
    return items.fold(0.0, (sum, item) {
      final price = (item['price'] ?? 0.0);
      final quantity = (item['quantity'] ?? 0) as int;
      return sum + (price * quantity);
    });
  }
}
