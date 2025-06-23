import 'package:swift_mobile_app/features/seller/home/domain/entities/product_entity.dart';

class ProductModel {
  final int id;
  final int categoryId;
  final String name;
  final int price;
  final String description;
  final List<dynamic> image;
  final int stock;

  ProductModel({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.price,
    required this.description,
    required this.image,
    required this.stock,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json['id'] as int,
    categoryId: json['category_id'] as int,
    name: json['name'] as String,
    price: json['price'] as int,
    description: json['description'] as String,
    image: json['images'] ,
    stock: json['stock'] as int,
  );

  ProductEntity toEntity() => ProductEntity(
    id: id,
    categoryId: categoryId,
    name: name,
    price: price,
    description: description,
    image: image,
    stock: stock,
  );
}
