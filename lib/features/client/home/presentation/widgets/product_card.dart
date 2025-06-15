import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swift_mobile_app/features/client/home/domain/entities/product_entity.dart';
import 'package:swift_mobile_app/features/client/product_details/presentation/views/product_details_view.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product, required this.index});
  final ProductEntity product;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          () => Navigator.pushNamed(
            context,
            ClientProductInfoView.routName,
            arguments: product,
          ),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.network(
                product.image[index],
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Icon(Icons.error, size: 50, color: Colors.red),
                  );
                },
                height: 199.h,
                width: 157.w,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(height: 5),
            Expanded(
              child: Padding(
                padding: EdgeInsetsGeometry.only(left: 8),
                child: Text(product.name, style: TextStyle(fontSize: 16)),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
              child: Text(
                '\$ ${product.price}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
