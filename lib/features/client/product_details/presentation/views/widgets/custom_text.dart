import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:swift_mobile_app/core/utils/app_font_styles.dart';
import 'package:swift_mobile_app/features/client/product_details/presentation/views/widgets/product_info_view_body.dart';

class CustomText extends StatelessWidget {
  const CustomText({super.key, required this.widget});

  final ProductInfoViewBody widget;

  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      style: AppTextStyles.w400_16.copyWith(color: Colors.black54),
      widget.product.description,
      trimLines: 3,
      colorClickableText: Colors.blue,
      trimMode: TrimMode.Line,
      trimCollapsedText: 'قراءة المزيد',
      trimExpandedText: 'إظهار أقل',
      moreStyle: AppTextStyles.w400_12.copyWith(color: Colors.black),

      lessStyle: AppTextStyles.w400_12.copyWith(color: Colors.black54),
      textAlign: TextAlign.center,
    );
  }
}
