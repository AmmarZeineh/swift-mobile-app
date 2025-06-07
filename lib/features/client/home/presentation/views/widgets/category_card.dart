import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swift_mobile_app/core/utils/app_colors.dart';
import 'package:swift_mobile_app/core/utils/app_font_styles.dart';
import 'package:swift_mobile_app/features/client/home/domain/entities/category_card_entity.dart';

class CategreyCard extends StatelessWidget {
  const CategreyCard({
    super.key,
    required this.categoryCardEntity,
    required this.onTap,
    required this.isSelected,
  });
  final CategoryCardEntity categoryCardEntity;
  final void Function()? onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: isSelected ? AppColors.primaryColor : Colors.grey,
                width: 3,
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
            ),
            height: 44.h,
            width: 44.w,
            child: Image.network(categoryCardEntity.image),
          ),
        ),
        SizedBox(height: 5.h),
        Text(
          categoryCardEntity.name,
          style: AppTextStyles.w600_14.copyWith(
            color: AppColors.secondaryColor,
          ),
        ),
      ],
    );
  }
}
