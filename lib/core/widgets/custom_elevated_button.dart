import 'package:flutter/material.dart';
import 'package:swift_mobile_app/core/utils/app_colors.dart';
import 'package:swift_mobile_app/core/utils/app_font_styles.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.width = double.infinity,
  });
  final String title;
  final void Function() onPressed;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          backgroundColor: AppColors.primaryColor,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 29, vertical: 15),
          child: Text(
            title,
            style: AppTextStyles.w600_18.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
