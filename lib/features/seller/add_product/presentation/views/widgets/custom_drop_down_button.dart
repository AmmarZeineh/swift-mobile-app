import 'package:flutter/material.dart';
import 'package:swift_mobile_app/core/utils/app_font_styles.dart';

class CustomDropDownButton extends StatelessWidget {
  final List<String> items;
  final String? selectedItem;
  final void Function(String?) onChanged;
  final String hintText;

  const CustomDropDownButton({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.onChanged,
    this.hintText = 'اختر عنصر',
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedItem,
      dropdownColor: Colors.white,
      onChanged: onChanged,
      hint: Text(
        hintText,
        style: AppTextStyles.w400_14.copyWith(color: Colors.grey.shade500),
      ),

      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      ),
      items:
          items
              .map(
                (item) => DropdownMenuItem<String>(
                  value: item,
                  alignment: AlignmentDirectional.centerEnd,
                  child: Text(item),
                ),
              )
              .toList(),
    );
  }
}
