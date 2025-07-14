import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final int id;
  final int categoryId;
  final String name;
  final num price;
  final String description;
  final List<dynamic> image;
  final int stock;
  final num rating;
  final bool hasAttributes;

  const ProductEntity({
    required this.rating,
    required this.hasAttributes,
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
    String? name,
    String? description,
    num? price,
    int? stock,
    List<dynamic>? images,
    double? rating,
    bool? hasAttributes,
  }) {
    return ProductEntity(
      id: id,
      rating: rating ?? this.rating,
      categoryId: categoryId,
      name: name ?? this.name,
      price: price?.toInt() ?? this.price,
      description: description ?? this.description,
      image: images ?? image,
      stock: stock ?? this.stock,
      hasAttributes: hasAttributes ?? this.hasAttributes,
    );
  }
}
