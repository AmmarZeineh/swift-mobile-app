import 'package:swift_mobile_app/features/client/home/domain/entities/category_card_entity.dart';

class CategoryModel {
  final int id;
  final String name;
  final String image;

  CategoryModel({required this.id, required this.name, required this.image});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json["id"],
      name: json['name'],
      image: json['image'],
    );
  }

  CategoryCardEntity toEntity() =>
      CategoryCardEntity(id: id, name: name, image: image);
}
