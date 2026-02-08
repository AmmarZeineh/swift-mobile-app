class ProductAttributeValueEntity {
  final int id;
  final int productId;
  final int attributeId;
  final String value;

  ProductAttributeValueEntity({
    required this.id,
    required this.productId,
    required this.attributeId,
    required this.value,
  });
}
