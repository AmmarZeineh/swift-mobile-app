import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swift_mobile_app/core/utils/app_colors.dart';
import 'package:swift_mobile_app/core/utils/app_font_styles.dart';
import 'package:swift_mobile_app/core/utils/app_images.dart';
import 'package:swift_mobile_app/features/client/cart/presentation/views/cart_view.dart';
import 'package:swift_mobile_app/features/client/home/presentation/views/search_view.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 24.w),

        GestureDetector(
          onTap: () => Navigator.pushNamed(context, SearchView.routeName),
          child: Padding(
            padding: EdgeInsets.only(top: 18.h),
            child: Image.asset(Assets.imagesSearch, width: 24, height: 24),
          ),
        ),

        Spacer(),
        Padding(
          padding: EdgeInsets.only(top: 5.h),
          child: Column(
            children: [
              Text(
                "الصفحة",
                style: AppTextStyles.w600_16.copyWith(
                  color: AppColors.secondaryColor,
                ),
              ),
              Text(
                "الرئيسية",
                style: AppTextStyles.w600_16.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
        ),
        Spacer(),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, CartView.routeName),
          child: Padding(
            padding: EdgeInsets.only(top: 18.h),
            child: Image.asset(Assets.imagesCart, width: 24, height: 24),
          ),
        ),
        SizedBox(width: 24.w),
      ],
    );
  }
}
