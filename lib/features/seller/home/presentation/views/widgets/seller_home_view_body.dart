// seller_home_view_body.dart
import 'package:flutter/material.dart';
import 'package:swift_mobile_app/core/utils/app_font_styles.dart';
import 'package:swift_mobile_app/core/widgets/product_card_widget.dart';
import 'package:swift_mobile_app/features/seller/home/domain/entities/product_entity.dart';
import 'package:swift_mobile_app/features/seller/home/presentation/views/seller_product_details_view.dart';

class SellerHomeViewBody extends StatelessWidget {
  // غيرناها من StatefulWidget لـ StatelessWidget
  const SellerHomeViewBody({super.key, required this.products});
  final List<ProductEntity> products;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: Text(
              'منتجاتي',
              style: AppTextStyles.w400_18,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 500,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 5 / 7.2,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        SellerProductDetailsView.routeName,
                        arguments:
                            products[index], // استخدمنا products بدلاً من widget.products
                      );
                    },
                    child: ProductCard(productEntity: products[index]),
                  );
                },
                itemCount: products.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
