import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swift_mobile_app/core/utils/app_colors.dart';
import 'package:swift_mobile_app/features/seller/home/domain/entities/product_entity.dart';

class ImagesPageViewBuilder extends StatefulWidget {
  const ImagesPageViewBuilder({super.key, required this.productEntity});
  final ProductEntity productEntity;

  @override
  State<ImagesPageViewBuilder> createState() => _ImagesPageViewBuilderState();
}

class _ImagesPageViewBuilderState extends State<ImagesPageViewBuilder> {
  PageController pageController = PageController();
  int currentIndex = 0;
  @override
  void initState() {
    pageController.addListener(() {
      setState(() {
        currentIndex = pageController.page!.round();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          controller: pageController,
          itemCount: widget.productEntity.image.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: CachedNetworkImage(
                  imageUrl: widget.productEntity.image[index],
                  width: double.infinity,
                  height: 170.h,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: DotsIndicator(
            dotsCount: widget.productEntity.image.length,
            position: currentIndex.roundToDouble(),
            decorator: DotsDecorator(
              shape: OvalBorder(
                side: BorderSide(color: AppColors.primaryColor),
              ),
              color: Colors.white, // Inactive color
              activeColor: AppColors.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
