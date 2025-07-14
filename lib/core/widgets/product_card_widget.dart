import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swift_mobile_app/core/entities/product_entity.dart';
import 'package:swift_mobile_app/core/utils/app_font_styles.dart';
import 'package:swift_mobile_app/core/widgets/images_page_view_builder.dart';

class SellerProductCard extends StatelessWidget {
  final ProductEntity productEntity;
  const SellerProductCard({super.key, required this.productEntity});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
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
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: ImagesPageViewBuilder(productEntity: productEntity),
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
        ),
        productEntity.hasAttributes
            ? SizedBox()
            : Positioned(
              top: 0,
              bottom: 0,
              right: 0,
              left: 0,
              child: SizeTransitionWarning(),
            ),
      ],
    );
  }
}

class SizeTransitionWarning extends StatefulWidget {
  const SizeTransitionWarning({super.key});

  @override
  SizeTransitionWarningState createState() => SizeTransitionWarningState();
}

class SizeTransitionWarningState extends State<SizeTransitionWarning>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 8),
        GestureDetector(
          onTap: () {
            if (_controller.isCompleted) {
              _controller.reverse();
            } else {
              _controller.forward();
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            padding: const EdgeInsets.all(8),
            child: Icon(Icons.warning, color: Colors.amber, size: 24),
          ),
        ),
        SizeTransition(
          sizeFactor: _animation,
          axis: Axis.horizontal,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: EdgeInsets.all(4),
              child: Text(
                'اضف تفاصيل للمنتج',
                style: AppTextStyles.w300_12.copyWith(color: Colors.amber),
                textAlign: TextAlign.end,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
