// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swift_mobile_app/core/utils/app_font_styles.dart';

class InfoActionButton extends StatelessWidget {
  const InfoActionButton({
    super.key,
    required this.title,
    this.onTap,
    required this.color,
    required this.icon,
  });

  final String title;
  final void Function()? onTap;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(color: Colors.grey.shade200, width: 1),
        ),
        child: Row(
          children: [
            RotatedBox(
              quarterTurns: 10,
              child: Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey.shade400,
                size: 16.sp,
              ),
            ),
            Spacer(),
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.w600_16.copyWith(
                  color: Colors.grey.shade800,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(icon, color: color, size: 24.sp),
            ),
          ],
        ),
      ),
    );
  }
}
