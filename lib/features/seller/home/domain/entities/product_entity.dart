import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final int id;
  final int categoryId;
  final String name;
  final num price;
  final String description;
  final List<dynamic> image;
  final int stock;

  const ProductEntity({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.price,
    required this.description,
    required this.image,
    required this.stock,
  });

  @override
  List<Object?> get props => [id];

  ProductEntity copyWith({
    required String name,
    required String description,
    required num price,
    required int stock,
    List<dynamic>? images,
  }) {
    return ProductEntity(
      id: id,
      categoryId: categoryId,
      name: name,
      price: price.toInt(),
      description: description,
      image: images ?? image,
      stock: stock,
    );
  }
}
