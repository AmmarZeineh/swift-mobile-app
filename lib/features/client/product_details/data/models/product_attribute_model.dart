import 'package:swift_mobile_app/features/client/product_details/domain/entities/product_attribute_entity.dart';

class ProductAttributeModel {
  final int id;
  final int categoryId;
  final String name;
  final bool isRequierd;

  ProductAttributeModel({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.isRequierd,
  });

  factory ProductAttributeModel.fromJson(Map<String, dynamic> json) {
    return ProductAttributeModel(
      id: json['id'],
      categoryId: json['category_id'],
      name: json['name'],
      isRequierd: json['is_required'] ?? false,
    );
  }

  ProductAttributeEntity toEntity() => ProductAttributeEntity(
    id: id,
    categoryId: categoryId,
    name: name,
    isRequired: isRequierd,
  );
}
