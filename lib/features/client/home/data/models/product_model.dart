import 'package:swift_mobile_app/features/client/home/domain/entities/product_entity.dart';

class ProductModel {
  final String name;
  final String description;
  final int price;
  final int stock;
  final List<String> image;

  ProductModel({
    required this.description,
    required this.price,
    required this.stock,
    required this.name,
    required this.image,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      name: json['name'],
      image:
          (json['images'] as List<dynamic>).map((e) => e.toString()).toList(),
      description: json["description"],
      price: json['price'],
      stock: json['stock'],
    );
  }

  ProductEntity toEntity() => ProductEntity(
    name: name,
    image: image,
    description: description,
    price: price,
    stock: stock,
  );
}
