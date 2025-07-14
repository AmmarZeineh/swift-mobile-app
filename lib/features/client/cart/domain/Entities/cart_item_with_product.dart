import 'package:swift_mobile_app/features/client/home/domain/entities/product_entity.dart';

class CartItemWithProductEntity {
  final int id;
  final DateTime createdAt;
  final String userId;
  final int productId;
  final int quantity;
  final String selectedAttriute;
  final ProductEntity product;

  CartItemWithProductEntity({
    required this.id,
    required this.createdAt,
    required this.userId,
    required this.productId,
    required this.quantity,
    required this.product,
    required this.selectedAttriute,
  });

  num get totalPrice => product.price * quantity;
}
