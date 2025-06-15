import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swift_mobile_app/features/client/home/domain/entities/product_entity.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(20),
        bottomLeft: Radius.circular(20),
      ),
      child: Image.network(
        product.image[0],
        errorBuilder: (context, error, stackTrace) {
          return Center(child: Icon(Icons.error, size: 50, color: Colors.red));
        },
        height: 455.h,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}
