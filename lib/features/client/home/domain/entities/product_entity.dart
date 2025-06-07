class ProductEntity {
  final String name;
  final int price;
  final String description;
  final List<String> image;
  final int stock;

  ProductEntity({
    required this.name,
    required this.price,
    required this.description,
    required this.image,
    required this.stock,
  });
}
