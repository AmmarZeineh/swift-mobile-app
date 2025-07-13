import 'package:flutter/material.dart';
import 'package:swift_mobile_app/features/client/product_details/domain/entities/attribute_with_value.dart';
import 'package:swift_mobile_app/features/client/product_details/presentation/views/widgets/product_attribut_card.dart';

class AttributeListView extends StatelessWidget {
  const AttributeListView({
    super.key,
    required this.attributesWithValues,
    this.onValueSelected,
  });
  final void Function(String attributeName, String selectedValue)?
  onValueSelected;
  final List<ProductAttributeWithValues> attributesWithValues;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: attributesWithValues.length,
      itemBuilder: (context, index) {
        final item = attributesWithValues[index];
        return SimpleProductAttributeCard(
          onValueSelected: onValueSelected,
          attributeWithValues: item,
        );
      },
    );
  }
}
