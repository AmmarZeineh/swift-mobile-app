import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift_mobile_app/core/helper_functions/show_dialog.dart';
import 'package:swift_mobile_app/core/services/get_it_service.dart';
import 'package:swift_mobile_app/core/utils/app_font_styles.dart';
import 'package:swift_mobile_app/features/seller/home/domain/entities/product_entity.dart';
import 'package:swift_mobile_app/features/seller/home/domain/repos/seller_home_repo.dart';
import 'package:swift_mobile_app/features/seller/home/presentation/cubits/product_attributes_cubit/product_attributes_cubit.dart';
import 'package:swift_mobile_app/features/seller/home/presentation/views/widgets/product_details_attribute_values_section.dart';
import 'package:swift_mobile_app/features/seller/home/presentation/views/widgets/product_details_row.dart';

class SellerProductDetailsViewBody extends StatefulWidget {
  const SellerProductDetailsViewBody({super.key, required this.productEntity});
  final ProductEntity productEntity;

  @override
  State<SellerProductDetailsViewBody> createState() =>
      _SellerProductDetailsViewBodyState();
}

class _SellerProductDetailsViewBodyState
    extends State<SellerProductDetailsViewBody> {
  // إنشاء متغير محلي للمنتج
  late ProductEntity currentProduct;

  @override
  void initState() {
    super.initState();
    // نسخ البيانات إلى المتغير المحلي
    currentProduct = widget.productEntity;

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
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: CachedNetworkImage(imageUrl: currentProduct.image[0]),
            ),
            SizedBox(height: 16),
            ProductDetailsRow(
              title: 'الاسم',
              value: currentProduct.name,
              onPressed: () {
                showEditDialog(context, 'الاسم', currentProduct.name, (
                  value,
                ) async {
                  await getIt.get<SellerHomeRepo>().editProductDetails(
                    'id',
                    currentProduct.id.toString(),
                    {'name': value},
                  );
                  if (context.mounted) {
                    // تحديث البيانات المحلية
                    setState(() {
                      currentProduct = currentProduct.copyWith(
                        name: value,
                        stock: currentProduct.stock,
                        price: currentProduct.price,
                        description: currentProduct.description,
                      );
                    });
                    Navigator.pop(context, true);
                  }
                });
              },
            ),
            ProductDetailsRow(
              title: 'الوصف',
              value: currentProduct.description,
              onPressed: () {
                showEditDialog(context, 'الوصف', currentProduct.description, (
                  value,
                ) async {
                  await getIt.get<SellerHomeRepo>().editProductDetails(
                    'id',
                    currentProduct.id.toString(),
                    {'description': value},
                  );
                  if (context.mounted) {
                    setState(() {
                      currentProduct = currentProduct.copyWith(
                        stock: currentProduct.stock,
                        price: currentProduct.price,
                        name: currentProduct.name,
                        description: value,
                      );
                    });
                    Navigator.pop(context, true);
                  }
                });
              },
            ),
            ProductDetailsRow(
              title: 'السعر',
              value: '${currentProduct.price.toString()}\$',
              onPressed: () {
                showEditDialog(
                  context,
                  'السعر',
                  currentProduct.price.toString(),
                  (value) async {
                    await getIt.get<SellerHomeRepo>().editProductDetails(
                      'id',
                      currentProduct.id.toString(),
                      {'price': value},
                    );
                    if (context.mounted) {
                      setState(() {
                        currentProduct = currentProduct.copyWith(
                          description: currentProduct.description,
                          stock: currentProduct.stock,
                          price: double.tryParse(value) ?? currentProduct.price,
                          name: currentProduct.name,
                        );
                      });
                      Navigator.pop(context, true);
                    }
                  },
                );
              },
            ),
            ProductDetailsRow(
              title: 'العدد في المخزون',
              value: currentProduct.stock.toString(),
              onPressed: () {
                showEditDialog(
                  context,
                  'العدد في المخزون',
                  currentProduct.stock.toString(),
                  (value) async {
                    await getIt.get<SellerHomeRepo>().editProductDetails(
                      'id',
                      currentProduct.id.toString(),
                      {'stock': value},
                    );
                    if (context.mounted) {
                      setState(() {
                        currentProduct = currentProduct.copyWith(
                          description: currentProduct.description,
                          price: currentProduct.price,
                          name: currentProduct.name,
                          stock: int.tryParse(value) ?? currentProduct.stock,
                        );
                      });
                      Navigator.pop(context, true);
                    }
                  },
                );
              },
            ),
            ProductDetailsAttributeValuesSection(currentProduct: currentProduct),
          ],
        ),
      ),
    );
  }
}
