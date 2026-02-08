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
      padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 8.h),
      child: SizedBox(
        height: 50.h,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // النص في المنتصف دائمًا
            Center(
              child: Text(
                text,
                style: AppTextStyles.w700_18.copyWith(
                  fontSize: 18.sp,
                  color: AppColors.secondaryColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            // زر الرجوع (أو مساحة فارغة مقابلة)
            Align(
              alignment: Alignment.centerLeft,
              child:
                  isArrowActive
                      ? IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                          size: 24.sp,
                        ),
                      )
                      : SizedBox(width: 48.w), // نفس عرض الأيقونة تقريب
            ),
          ],
        ),
      ),
    );
  }
}
