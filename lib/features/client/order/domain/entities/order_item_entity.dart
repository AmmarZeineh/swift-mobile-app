class OrderItemEntity {
  final String id;
  final String orderId;
  final String productId;
  final int quantity;
  num price;
  String? productName;
  String? productImage;
  final String selectedAttribute;

  OrderItemEntity({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.quantity,
    required this.price,
    required this.selectedAttribute,
    this.productName,
    this.productImage,
  });
}
