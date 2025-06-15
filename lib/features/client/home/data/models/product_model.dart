import 'package:swift_mobile_app/features/client/home/domain/entities/product_entity.dart';

class ProductModel {
  final int id;
  final int categoryId;
  final String name;
  final String description;
  final int price;
  final int stock;
  final List<String> image;
  
  ProductModel({
    required this.id,
    required this.categoryId,
    required this.description,
    required this.price,
    required this.stock,
    required this.name,
    required this.image,
   
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      categoryId: json['category_id'],
      name: json['name'],
      image:
          (json['images'] as List<dynamic>).map((e) => e.toString()).toList(),
      description: json["description"],
      price: json['price'],
      stock: json['stock'],
      
    );
  }

  ProductEntity toEntity() => ProductEntity(
    id: id,
    categoryId: categoryId,
    name: name,
    image: image,
    description: description,
    price: price,
    stock: stock,
   
  );
}
