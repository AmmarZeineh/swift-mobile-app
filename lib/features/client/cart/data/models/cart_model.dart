import 'package:swift_mobile_app/features/client/cart/domain/Entities/cart_entity.dart';

class CartModel {
  final int id;
  final DateTime createdAt;
  final String userId;
  final int productId;
  final int quantity;
  final String selectedAttribute;

  CartModel({
    required this.id,
    required this.createdAt,
    required this.userId,
    required this.productId,
    required this.quantity,
    required this.selectedAttribute,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'] as int,
      createdAt: DateTime.parse(json['created_at']),
      userId: json['user_id'] as String,
      productId: json['product_id'] as int,
      quantity: json['quantity'] as int,
      selectedAttribute: json['selected_attributes_summary'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'user_id': userId,
      'product_id': productId,
      'quantity': quantity,
      'selected_attributes_summary': selectedAttribute
    };
  }

  CartEntity toEntity() => CartEntity(
    id: id,
    createdAt: createdAt,
    userId: userId,
    productId: productId,
    quantity: quantity,
    selectedAttribute: selectedAttribute
  );
}
