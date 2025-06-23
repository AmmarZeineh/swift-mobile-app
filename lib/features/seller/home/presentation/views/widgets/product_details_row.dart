import 'package:flutter/material.dart';
import 'package:swift_mobile_app/core/utils/app_font_styles.dart';

class ProductDetailsRow extends StatelessWidget {
  const ProductDetailsRow({
    super.key,
    required this.title,
    required this.value,
    required this.onPressed,
  });
  final String title;
  final String value;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(onPressed: onPressed, icon: Icon(Icons.edit)),
        Spacer(),
        Text(value, style: AppTextStyles.w400_16.copyWith(color: Colors.grey)),
        Text(' :$title', style: AppTextStyles.w400_16),
      ],
    );
  }
}
