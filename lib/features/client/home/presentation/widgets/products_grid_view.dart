import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swift_mobile_app/features/client/home/domain/entities/product_entity.dart';
import 'package:swift_mobile_app/features/client/home/presentation/widgets/product_card.dart';

class ProductsGridView extends StatefulWidget {
  const ProductsGridView({super.key, required this.products});
  final List<ProductEntity> products;

  @override
  State<ProductsGridView> createState() => _ProductsGridViewState();
}

class _ProductsGridViewState extends State<ProductsGridView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15.h,
          mainAxisSpacing: 10.w,
          childAspectRatio: 0.65,
        ),
        itemCount: widget.products.length,
        itemBuilder: (context, index) {
          return ProductCard(product: widget.products[index], index: index);
        },
      ),
    );
  }
}
