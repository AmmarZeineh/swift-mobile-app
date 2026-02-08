import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../../core/entities/product_entity.dart';

class ProductImage extends StatefulWidget {
  const ProductImage({super.key, required this.product});

  final ProductEntity product;

  @override
  State<ProductImage> createState() => _ProductImageState();
}

class _ProductImageState extends State<ProductImage> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
          child: SizedBox(
            height: 300.h,
            width: double.infinity,
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.product.image.length,
              itemBuilder: (context, index) {
                return CachedNetworkImage(
                  imageUrl: widget.product.image[index],
                  height: 300.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorWidget:
                      (context, url, error) => Center(
                        child: Icon(Icons.error, size: 50, color: Colors.red),
                      ),
                  placeholder:
                      (context, url) =>
                          Center(child: CircularProgressIndicator()),
                );
              },
            ),
          ),
        ),
        SizedBox(height: 10.h),
        SmoothPageIndicator(
          controller: _pageController,
          count: widget.product.image.length,
          effect: WormEffect(
            dotHeight: 8,
            dotWidth: 8,
            spacing: 8,
            activeDotColor: Colors.black,
            dotColor: Colors.grey.shade300,
          ),
        ),
      ],
    );
  }
}
