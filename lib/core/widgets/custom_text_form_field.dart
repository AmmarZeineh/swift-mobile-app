import 'package:flutter/material.dart';
import 'package:swift_mobile_app/core/utils/app_font_styles.dart';

class CustomFormTextField extends StatelessWidget {
  const CustomFormTextField({
    super.key,
    required this.title,
    required this.textInputType,
    this.prefixIcon,
    this.onSaved,
    this.obscureText = false,
    this.maxLines = 1,
  });
  final String title;
  final TextInputType textInputType;
  final Widget? prefixIcon;
  final void Function(String?)? onSaved;
  final bool obscureText;
  final int maxLines;
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
        prefixIcon: prefixIcon,
        border: buildBorder(),
        focusedBorder: buildBorder(),
        enabledBorder: buildBorder(),
        label: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.w400_14.copyWith(color: Colors.grey),
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  UnderlineInputBorder buildBorder() {
    return UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.grey, width: 1.8),
    );
  }
}
