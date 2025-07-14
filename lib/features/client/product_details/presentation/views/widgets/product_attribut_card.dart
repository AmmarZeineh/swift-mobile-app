import 'package:flutter/material.dart';
import 'package:swift_mobile_app/core/utils/app_colors.dart';
import 'package:swift_mobile_app/core/utils/app_font_styles.dart';
import 'package:swift_mobile_app/features/client/product_details/domain/entities/attribute_with_value.dart';

class SimpleProductAttributeCard extends StatefulWidget {
  final ProductAttributeWithValues attributeWithValues;
  final void Function(String attributeName, String selectedValue)?
  onValueSelected;

  const SimpleProductAttributeCard({
    super.key,
    required this.attributeWithValues,
    this.onValueSelected,
  });

  @override
  State<SimpleProductAttributeCard> createState() =>
      _SimpleProductAttributeCardState();
}

class _SimpleProductAttributeCardState
    extends State<SimpleProductAttributeCard> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    final attribute = widget.attributeWithValues.attribute;
    final values = widget.attributeWithValues.values;

    // هذا السطر يفترض أنك أضفت isRequired في ProductAttributeEntity
    final isRequired = attribute.isRequired;

    if (!isRequired) {
      final joinedValues = values.map((e) => e.value).join(", ");
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFF9F3E9),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Text(
                "${attribute.name} : ",
                style: AppTextStyles.w600_16.copyWith(
                  color: AppColors.secondaryColor,
                ),
              ),
              Text(
                joinedValues,
                style: AppTextStyles.w400_16.copyWith(color: Colors.black),
              ),
            ],
          ),
        ),
      );
    }

    // مواصفة اختيارية (لون أو مقاس مثلاً)
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${attribute.name} :",
            style: AppTextStyles.w700_18.copyWith(
              color: AppColors.secondaryColor,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            children:
                values.map((value) {
                  final isSelected = selectedValue == value.value;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedValue = value.value;
                      });

                      if (widget.onValueSelected != null) {
                        widget.onValueSelected!(attribute.name, value.value);
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 5),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color:
                            isSelected
                                ? AppColors.primaryColor
                                : const Color(0xFFF9F3E9),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color:
                              isSelected
                                  ? AppColors.primaryColor
                                  : Colors.grey.shade400,
                        ),
                      ),
                      child: Text(
                        value.value,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }).toList(),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
