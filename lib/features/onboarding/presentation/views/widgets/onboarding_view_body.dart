import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swift_mobile_app/core/utils/app_colors.dart';
import 'package:swift_mobile_app/core/utils/app_font_styles.dart';
import 'package:swift_mobile_app/core/utils/app_images.dart';
import 'package:swift_mobile_app/core/widgets/custom_elevated_button.dart';
import 'package:swift_mobile_app/features/client/home/presentation/views/client_home_view.dart';
import 'package:swift_mobile_app/features/seller/auth/presentation/views/seller_signup_view.dart';

class OnboardingViewBody extends StatelessWidget {
  const OnboardingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SvgPicture.asset(Assets.imagesOnboardingDelivery),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: 32.h),
              Text(
                'طلبك بيوصل',
                style: AppTextStyles.w600_20.copyWith(color: Color(0XFF606060)),
              ),
              SizedBox(height: 8),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'أسرع من',
                      style: AppTextStyles.w700_30.copyWith(
                        color: AppColors.secondaryColor,
                      ),
                    ),
                    TextSpan(
                      text: ' البرق',
                      style: AppTextStyles.w700_30.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24),
              Text(
                'تياب، إلكترونيات، مكياجات… شو ما خطر عبالك، موجود بسويفت بتجربة بتخليك ترجع كل يوم',
                style: AppTextStyles.w400_18.copyWith(color: Color(0xFF808080)),
                textAlign: TextAlign.end,
              ),
              SizedBox(height: 325.h),
              CustomElevatedButton(
                title: 'انا بائع',
                onPressed: () {
                  Navigator.pushReplacementNamed(
                    context,
                    SellerSignupView.routeName,
                  );
                },
              ),
              SizedBox(height: 12),
              CustomElevatedButton(
                title: 'انا مشتري',
                onPressed: () {
                  Navigator.pushReplacementNamed(
                    context,
                    ClientHomeView.routeName,
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
