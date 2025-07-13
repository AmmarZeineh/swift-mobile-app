import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:swift_mobile_app/core/utils/app_colors.dart';
import 'package:swift_mobile_app/core/utils/app_font_styles.dart';
import 'package:swift_mobile_app/features/client/home/domain/entities/product_entity.dart';
import 'package:swift_mobile_app/features/client/product_details/presentation/views/product_details_view.dart';

class ProductCard extends StatefulWidget {
  final ProductEntity productEntity;
  const ProductCard({super.key, required this.productEntity});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          ClientProductInfoView.routName,
          arguments: widget.productEntity,
        );
      },
      child: Container(
        width: 160.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image + Icon stack
            ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: SizedBox(
                height: 170.h,
                width: double.infinity,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: widget.productEntity.image.length,
                  itemBuilder: (context, index) {
                    return CachedNetworkImage(
                      imageUrl: widget.productEntity.image[index],
                      width: double.infinity,
                      height: 170.h,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Center(
              child: SmoothPageIndicator(
                controller: _pageController,
                count: widget.productEntity.image.length,
                effect: WormEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  spacing: 8,
                  activeDotColor: AppColors.primaryColor,
                  dotColor: Colors.grey.shade300,
                ),
              ),
            ),

            SizedBox(height: 8.h),
            // Product Name
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                widget.productEntity.name,
                style: AppTextStyles.w400_14.copyWith(color: Colors.grey),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              child: Text(
                '\$ ${widget.productEntity.price}',
                style: AppTextStyles.w700_16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
