
import 'package:swift_mobile_app/features/client/product_details/domain/entities/product_attribute_value_entity.dart';

class AttributeValueModel {
  final int id;
  final int productId;
  final int attributeId;
  final String value;

  AttributeValueModel({
    required this.id,
    required this.productId,
    required this.attributeId,
    required this.value,
  });

  factory AttributeValueModel.fromJson(Map<String, dynamic> json) {
    return AttributeValueModel(
      id: json['id'],
      productId: json['product_id'],
      attributeId: json['attribute_id'],
      value: json['value'],
    );
  }

  ProductAttributeValueEntity toEntity() => ProductAttributeValueEntity(
    id: id,
    productId: productId,
    attributeId: attributeId,
    value: value,
  );
}
