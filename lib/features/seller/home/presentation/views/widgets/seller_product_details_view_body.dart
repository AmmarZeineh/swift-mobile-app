import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift_mobile_app/core/utils/app_font_styles.dart';
import 'package:swift_mobile_app/features/seller/home/domain/entities/product_entity.dart';
import 'package:swift_mobile_app/features/seller/home/presentation/cubits/product_attributes_cubit/product_attributes_cubit.dart';

class SellerProductDetailsViewBody extends StatefulWidget {
  const SellerProductDetailsViewBody({super.key, required this.productEntity});
  final ProductEntity productEntity;

  @override
  State<SellerProductDetailsViewBody> createState() =>
      _SellerProductDetailsViewBodyState();
}

class _SellerProductDetailsViewBodyState
    extends State<SellerProductDetailsViewBody> {
  @override
  void initState() {
    super.initState();
    // نادي على الـ cubit مرة واحدة فقط
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductAttributesCubit>().fetchAttributesWithValues(
        widget.productEntity.categoryId,
        widget.productEntity.id,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: Text(
                'تفاصيل المنتج',
                style: AppTextStyles.w400_18,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 24),
            ProductDetailsRow(title: 'الاسم', value: widget.productEntity.name),
            ProductDetailsRow(
              title: 'الوصف',
              value: widget.productEntity.description,
            ),
            ProductDetailsRow(
              title: 'السعر',
              value: '${widget.productEntity.price.toString()}\$',
            ),
            ProductDetailsRow(
              title: 'العدد في المخزون',
              value: widget.productEntity.stock.toString(),
            ),

            // عرض الـ attributes بناءً على state الـ cubit
            BlocBuilder<ProductAttributesCubit, ProductAttributesState>(
              builder: (context, state) {
                if (state is ProductAttributesSuccess) {
                  return Column(
                    children: [
                      SizedBox(height: 16),
                      ...state.data.map(
                        (attributeWithValues) => ProductDetailsRow(
                          title: attributeWithValues.attribute.name,
                          value: attributeWithValues.values
                              .map((v) => v.value)
                              .join(', '),
                        ),
                      ),
                    ],
                  );
                }
                return SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ProductDetailsRow extends StatelessWidget {
  const ProductDetailsRow({
    super.key,
    required this.title,
    required this.value,
  });
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
        Spacer(),
        Text(value, style: AppTextStyles.w400_16.copyWith(color: Colors.grey)),
        Text(' :$title', style: AppTextStyles.w400_16),
      ],
    );
  }
}
