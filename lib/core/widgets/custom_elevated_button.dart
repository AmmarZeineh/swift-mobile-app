import 'package:flutter/material.dart';
import 'package:swift_mobile_app/core/utils/app_colors.dart';
import 'package:swift_mobile_app/core/utils/app_font_styles.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.title,
    required this.onPressed,
    required this.padding,
  });
  final String title;
  final void Function() onPressed;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          backgroundColor: AppColors.primaryColor,
        ),
        child: Padding(
          padding: padding,
          child: Text(
            title,
            textAlign: TextAlign.right,
            style: AppTextStyles.w600_18.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
