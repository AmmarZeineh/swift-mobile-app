import 'package:swift_mobile_app/features/seller/home/domain/entities/product_entity.dart';

class ProductModel {
  final int id;
  final int categoryId;
  final String name;
  final num price;
  final String description;
  final List<dynamic> image;
  final int stock;
  final bool hasAttributes;

  ProductModel({
    required this.hasAttributes,
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
    price: json['price'] as num,
    description: json['description'] as String,
    image: json['images'],
    stock: json['stock'] as int,
    hasAttributes: json['hasAttributes'] as bool,
  );

  factory ProductModel.fromEntity(ProductEntity entity) => ProductModel(
    hasAttributes: entity.hasAttributes,
    id: entity.id,
    categoryId: entity.categoryId,
    name: entity.name,
    price: entity.price,
    description: entity.description,
    image: entity.image,
    stock: entity.stock,
  );

  ProductEntity toEntity() => ProductEntity(
    id: id,
    hasAttributes: hasAttributes,
    categoryId: categoryId,
    name: name,
    price: price,
    description: description,
    image: image,
    stock: stock,
  );
  toJson(int sellerId) => {
    'category_id': categoryId,
    'name': name,
    'price': price,
    'description': description,
    'images': image,
    'stock': stock,
    'seller_id': sellerId,
  };
}
