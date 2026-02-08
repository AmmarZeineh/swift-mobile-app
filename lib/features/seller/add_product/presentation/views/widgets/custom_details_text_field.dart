import 'package:flutter/material.dart';
import 'package:swift_mobile_app/core/utils/app_colors.dart';
import 'package:swift_mobile_app/core/utils/app_font_styles.dart';

class CustomDetailsTextField extends StatelessWidget {
  const CustomDetailsTextField({
    super.key,
    this.maxLines = 1,
    required this.textInputType,
    this.obscureText = false,
    required this.onSaved,
    required this.title,
  });

  final int maxLines;
  final TextInputType textInputType;
  final bool obscureText;
  final void Function(String?) onSaved;
  final String title;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      textDirection: TextDirection.rtl,
      style: const TextStyle(color: Colors.black),
      obscureText: obscureText,
      onSaved: onSaved,
      validator: (value) {
        if (value!.isEmpty) {
          return 'هذا الحقل مطلوب';
        }
        return null;
      },
      keyboardType: textInputType,

      decoration: InputDecoration(
        hintTextDirection: TextDirection.rtl,
        border: buildBorder(),
        focusedBorder: buildBorder(),
        enabledBorder: buildBorder(),
        labelText: title,

        labelStyle: AppTextStyles.w400_14.copyWith(color: Colors.grey.shade500),
      ),
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.secondaryColor, width: 1.8),
    );
  }
}
