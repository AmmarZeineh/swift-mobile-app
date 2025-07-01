import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift_mobile_app/core/cubits/user_cubit.dart';
import 'package:swift_mobile_app/core/helper_functions/snack_bars.dart';
import 'package:swift_mobile_app/core/widgets/custom_elevated_button.dart';
import 'package:swift_mobile_app/features/seller/add_product/presentation/cubits/add_product_cubit/add_product_cubit.dart';
import 'package:swift_mobile_app/features/seller/add_product/presentation/cubits/fetch_categories_cubit/fetch_categories_cubit.dart';
import 'package:swift_mobile_app/features/seller/add_product/presentation/views/widgets/custom_details_text_field.dart';
import 'package:swift_mobile_app/features/seller/add_product/presentation/views/widgets/custom_drop_down_button.dart';
import 'package:swift_mobile_app/features/seller/add_product/presentation/views/widgets/product_image_uploader.dart';
import 'package:swift_mobile_app/features/seller/home/domain/entities/product_entity.dart';
import 'package:swift_mobile_app/features/seller/home/presentation/cubits/fetch_products_cubit/fetch_products_cubit.dart';

class BasicProductDetailsCardSection extends StatefulWidget {
  const BasicProductDetailsCardSection({super.key});

  @override
  State<BasicProductDetailsCardSection> createState() =>
      _BasicProductDetailsCardSectionState();
}

class _BasicProductDetailsCardSectionState extends State<BasicProductDetailsCardSection> {
  List<File> images = [];
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.grey),
      ),
      elevation: 2,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            SizedBox(height: 24),
            ProductImageUploader(
              onImagesChanged: (images) {
                this.images = images;
              },
            ),
            SizedBox(height: 24),
            CustomDetailsTextField(
              textInputType: TextInputType.text,
              onSaved: (value) {},
              title: 'الاسم',
            ),
            SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: CustomDetailsTextField(
                    textInputType: TextInputType.number,
                    onSaved: (value) {},
                    title: 'السعر',
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: CustomDetailsTextField(
                    textInputType: TextInputType.number,
                    onSaved: (value) {},
                    title: 'العدد',
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            CustomDetailsTextField(
              textInputType: TextInputType.text,
              onSaved: (value) {},
              title: 'الوصف',
              maxLines: 3,
            ),
            SizedBox(height: 24),
            BlocBuilder<FetchCategoriesCubit, FetchCategoriesState>(
              builder: (context, state) {
                if (state is FetchCategoriesSuccess) {
                  return CustomDropDownButton(
                    hintText: 'اختر فئة المنتج',
                    items:
                        state.categories
                            .where(
                              (e) => e.name != 'الكل',
                            ) // احذف العناصر يلي اسمها 'الكل'
                            .map((e) => e.name)
                            .toList(),
                    selectedItem: null,
                    onChanged: (value) {},
                  );
                } else if (state is FetchCategoriesFailure) {
                  return Center(child: Text(state.errMessage));
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
            SizedBox(height: 24),

            BlocListener<AddProductCubit, AddProductState>(
              listener: (context, state) {
                if (state is AddProductSuccess) {
                  showSuccessMessage('تم رفع المنتج', context);
                }
                if (state is AddProductFailure) {
                  showErrorMessage(state.errMessage, context);
                }
              },
              child: CustomElevatedButton(
                title: 'رفع المنتج',
                onPressed: () async {
                  await context.read<AddProductCubit>().addProduct(
                    images,
                    ProductEntity(
                      id: 0,
                      categoryId: 2,
                      name: 'name',
                      price: 10,
                      description: 'description',
                      image: images,
                      stock: 5,
                    ),
                    context.read<UserCubit>().currentUser!.sellerId,
                  );
                  if (context.mounted) {
                    context.read<FetchProductsCubit>().fetchProducts(
                      context.read<UserCubit>().currentUser!.sellerId,
                    );
                  }
                },
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              ),
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
