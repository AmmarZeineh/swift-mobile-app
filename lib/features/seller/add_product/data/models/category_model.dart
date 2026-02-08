import 'package:swift_mobile_app/features/seller/add_product/domain/entities/category_entity.dart';

class CategoryModel {
  final int id;
  final String name;

  CategoryModel({required this.id, required this.name});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(id: json['id'], name: json['name']);
  }

  CategoryEntity toEntity() => CategoryEntity(id: id, name: name);
}
