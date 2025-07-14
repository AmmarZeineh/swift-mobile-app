import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swift_mobile_app/core/utils/app_colors.dart';
import 'package:swift_mobile_app/core/utils/app_font_styles.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.text,
    this.isArrowActive = true,
  });
  final String text;
  final bool isArrowActive;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: isArrowActive ? 0 : 10),
      child: Row(
        children: [
          SizedBox(width: 16.w),
          isArrowActive
              ? IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back, color: Colors.black, size: 20),
              )
              : SizedBox(width: 50),
          SizedBox(width: 100),
          Text(
            text,
            style: AppTextStyles.w700_18.copyWith(
              color: AppColors.secondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
