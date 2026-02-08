class CartEntity {
  final int id;
  final DateTime createdAt;
  final String userId;
  final int productId;
  final int quantity;
  final String selectedAttribute;

  CartEntity({
    required this.id,
    required this.createdAt,
    required this.userId,
    required this.productId,
    required this.quantity,
    required this.selectedAttribute
  });
}
