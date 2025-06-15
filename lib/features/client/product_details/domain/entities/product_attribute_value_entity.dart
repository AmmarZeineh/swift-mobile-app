import 'package:swift_mobile_app/features/client/product_details/domain/entities/product_attribute_entity.dart';

class ProductAttributeValueEntity {
  final int id;
  final int productId;
  final int attributeId;
  final String value;

  ProductAttributeValueEntity({
   required this.id,
    required this.productId,
    required this.attributeId,
    required this.value,
  });
}
