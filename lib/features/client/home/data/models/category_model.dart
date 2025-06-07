import 'package:swift_mobile_app/features/client/home/domain/entities/category_card_entity.dart';

class CategoryModel {
  final String name;
  final String image;

  CategoryModel({required this.name, required this.image});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(name: json['name'], image: json['image']);
  }

  CategoryCardEntity toEntity() => CategoryCardEntity(name: name, image: image);
}
