import 'package:swift_mobile_app/features/client/product_details/domain/entities/product_attribute_entity.dart';
import 'package:swift_mobile_app/features/client/product_details/domain/entities/product_attribute_value_entity.dart';

class ProductAttributeWithValues {
  final ProductAttributeEntity attribute;
  final List<ProductAttributeValueEntity> values;

  ProductAttributeWithValues({
    required this.attribute,
    required this.values,
  });
}
