import 'package:swift_mobile_app/features/client/order/domain/entities/order_item_entity.dart';

class OrderItemModel extends OrderItemEntity {
  OrderItemModel({
    required super.id,
    required super.orderId,
    required super.productId,
    required super.quantity,
    required super.price,
    super.productName,
    super.productImage,
    required super.selectedAttribute,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      id: json['id'].toString(),
      orderId: json['order_id'].toString(),
      productId: json['product_id'].toString(),
      quantity: json['quantity'] ?? 0,
      price: (json['price'] ?? 0.0),
      productName: json['product_name'],
      productImage: json['product_image'],
      selectedAttribute: json["selected_attributes_summary"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order_id': orderId,
      'product_id': productId,
      'quantity': quantity,
      'price': price,
      'product_name': productName,
      'product_image': productImage,
    };
  }
}
