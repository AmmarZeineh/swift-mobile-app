import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift_mobile_app/core/helper_functions/show_dialog.dart';
import 'package:swift_mobile_app/core/services/get_it_service.dart';
import 'package:swift_mobile_app/core/utils/app_font_styles.dart';
import 'package:swift_mobile_app/features/seller/home/domain/entities/product_entity.dart';
import 'package:swift_mobile_app/features/seller/home/domain/repos/seller_home_repo.dart';
import 'package:swift_mobile_app/features/seller/home/presentation/cubits/product_attributes_cubit/product_attributes_cubit.dart';
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
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: CachedNetworkImage(
                imageUrl: widget.productEntity.image[0],
              ),
            ),
            SizedBox(height: 16),
            ProductDetailsRow(
              title: 'الاسم',
              value: widget.productEntity.name,
              onPressed: () {
                showEditDialog(context, 'الاسم', widget.productEntity.name, (
                  value,
                ) async {
                  await getIt.get<SellerHomeRepo>().editProductDetails(
                    'id',
                    widget.productEntity.id.toString(),
                    {'name': value},
                  );
                  if (context.mounted) {
                    Navigator.pop(context, true);
                  }
                });
              },
            ),
            ProductDetailsRow(
              title: 'الوصف',
              value: widget.productEntity.description,
              onPressed: () {
                showEditDialog(
                  context,
                  'الوصف',
                  widget.productEntity.description,
                  (value) async {
                    await getIt.get<SellerHomeRepo>().editProductDetails(
                      'id',
                      widget.productEntity.id.toString(),
                      {'description': value},
                    );
                    if (context.mounted) {
                      Navigator.pop(context, true);
                    }
                  },
                );
              },
            ),
            ProductDetailsRow(
              title: 'السعر',
              value: '${widget.productEntity.price.toString()}\$',
              onPressed: () {
                showEditDialog(
                  context,
                  'السعر',
                  widget.productEntity.price.toString(),
                  (value) async {
                    await getIt.get<SellerHomeRepo>().editProductDetails(
                      'id',
                      widget.productEntity.id.toString(),
                      {'price': value},
                    );
                    if (context.mounted) {
                      Navigator.pop(context, true);
                    }
                  },
                );
              },
            ),
            ProductDetailsRow(
              title: 'العدد في المخزون',
              value: widget.productEntity.stock.toString(),
              onPressed: () {
                showEditDialog(
                  context,
                  'العدد في المخزون',
                  widget.productEntity.stock.toString(),
                  (value) async {
                    await getIt.get<SellerHomeRepo>().editProductDetails(
                      'id',
                      widget.productEntity.id.toString(),
                      {'stock': value},
                    );
                    if (context.mounted) {
                      Navigator.pop(context, true);
                    }
                  },
                );
              },
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
                          onPressed: () {},
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
