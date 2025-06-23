import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swift_mobile_app/core/utils/app_font_styles.dart';
import 'package:swift_mobile_app/features/seller/home/domain/entities/product_entity.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity productEntity;
  const ProductCard({super.key, required this.productEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image + Icon stack
          ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: CachedNetworkImage(
              imageUrl: productEntity.image[0],
              width: double.infinity,
              height: 170.h,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 8.h),
          // Product Name
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Text(
              productEntity.name,
              style: AppTextStyles.w400_14.copyWith(color: Colors.grey),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            child: Text(
              '\$ ${productEntity.price.toStringAsFixed(2)}',
              style: AppTextStyles.w700_16,
            ),
          ),
        ],
      ),
    );
  }
}
