class ProductEntity {
  final int id;
  final int categoryId;
  final String name;
  final int price;
  final String description;
  final List<dynamic> image;
  final int stock;

  ProductEntity({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.price,
    required this.description,
    required this.image,
    required this.stock,
  });
}
