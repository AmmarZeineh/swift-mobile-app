import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swift_mobile_app/core/cubits/user_cubit/user_cubit.dart';
import 'package:swift_mobile_app/core/helper_functions/snack_bars.dart';
import 'package:swift_mobile_app/core/utils/app_font_styles.dart';
import 'package:swift_mobile_app/core/widgets/custom_elevated_button.dart';
import 'package:swift_mobile_app/features/client/product_details/presentation/cubits/add_to_cart_cubit/add_to_cart_cubit.dart';
import 'package:swift_mobile_app/features/client/product_details/presentation/cubits/product_attribute_valuecubit/product_attribute_value_cubit.dart';
import 'package:swift_mobile_app/features/client/product_details/presentation/cubits/reviews_cubit/reviews_cubit.dart';
import 'package:swift_mobile_app/features/client/product_details/presentation/views/widgets/attribute_list_view.dart';
import 'package:swift_mobile_app/features/client/product_details/presentation/views/widgets/custom_counter.dart';
import 'package:swift_mobile_app/features/client/product_details/presentation/views/widgets/custom_text.dart';
import 'package:swift_mobile_app/features/client/product_details/presentation/views/widgets/product_image.dart';
import 'package:swift_mobile_app/features/client/product_details/presentation/views/widgets/product_review_widget.dart';

import '../../../../../../core/entities/product_entity.dart';

class ProductInfoViewBody extends StatefulWidget {
  const ProductInfoViewBody({super.key, required this.product});
  final ProductEntity product;

  @override
  State<ProductInfoViewBody> createState() => _ProductInfoViewBodyState();
}

class _ProductInfoViewBodyState extends State<ProductInfoViewBody> {
  final GlobalKey<CustomCounterState> counterKey =
      GlobalKey<CustomCounterState>();
  final Map<String, String> selectedAttributes = {};
  @override
  void initState() {
    context.read<ProductAttributesCubit>().fetchAttributesWithValues(
          widget.product.id,
          widget.product.categoryId,
        );
    context.read<ReviewsCubit>().fetchReviews(widget.product.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15),
        child: BlocConsumer<AddToCartCubit, AddToCartState>(
          listener: (context, state) {
            if (state is AddToCartSuccess) {
              showSuccessMessage("تم اضافة المنتج بنجاح", context);
            } else if (state is AddToCartFailure) {
              showErrorMessage(state.errMessage, context);
            }
          },
          builder: (context, state) {
            return CustomElevatedButton(
              title: state is AddToCartLoading ? "جاري الإضافة" : "اضافة للسلة",
              onPressed: state is AddToCartLoading
                  ? () {}
                  : () {
                      final quantity = counterKey.currentState?.count ?? 1;

                      // فحص المواصفات المطلوبة
                      final requiredAttributes = context
                              .read<ProductAttributesCubit>()
                              .state is ProductAttributesSuccess
                          ? (context.read<ProductAttributesCubit>().state
                                  as ProductAttributesSuccess)
                              .attributesWithValues
                              .where((e) => e.attribute.isRequired)
                              .map((e) => e.attribute.name)
                              .toList()
                          : [];

                      final allSelected = requiredAttributes.every(
                        (key) => selectedAttributes.containsKey(key),
                      );

                      if (!allSelected) {
                        showErrorMessage(
                          "يرجى اختيار جميع المواصفات المطلوبة",
                          context,
                        );
                        return;
                      }

                      // تجميع المواصفات كـ String
                      final selectedSummary = selectedAttributes.entries
                          .map((e) => "${e.key}: ${e.value}")
                          .join(", ");

                      // أرسل مع الداتا
                      context.read<AddToCartCubit>().addToCart(
                            userId: context.read<UserCubit>().currentUser!.id,
                            product: widget.product,
                            quantity: quantity,
                            selectedAttributesSummary:
                                selectedSummary, // ← أضف هذا الحقل
                          );
                    },
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(children: [buildProductContent()]),
        ),
      ),
    );
  }

  Widget buildProductContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ProductImage(product: widget.product),
        SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.product.name,
              style: AppTextStyles.w500_24.copyWith(color: Colors.black),
            ),
            Padding(
              padding: EdgeInsets.only(right: 30.w),
              child: Text(
                '\$ ${widget.product.price}',
                style: AppTextStyles.w700_30.copyWith(color: Colors.black),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            const Icon(Icons.star, color: Colors.yellow),
            const SizedBox(width: 10),
            Text(
              widget.product.rating.toString(),
              style: AppTextStyles.w700_18.copyWith(color: Colors.black),
            ),
            SizedBox(width: 160.w),
            CustomCounter(key: counterKey),
          ],
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: CustomText(widget: widget),
        ),
        SizedBox(height: 5.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(
            height: 315.h,
            child: BlocBuilder<ProductAttributesCubit, ProductAttributesState>(
              builder: (context, state) {
                if (state is ProductAttributesSuccess) {
                  return AttributeListView(
                    attributesWithValues: state.attributesWithValues,
                    onValueSelected: (attrName, selectedVal) {
                      setState(() {
                        selectedAttributes[attrName] = selectedVal;
                      });
                    },
                  );
                } else if (state is ProductAttributesFailure) {
                  return Center(child: Text('حدث خطأ: ${state.errMessage}'));
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: BlocBuilder<ReviewsCubit, ReviewsState>(
            builder: (context, state) {
              if (state is ReviewsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ReviewsError) {
                return Text(state.message, style: TextStyle(color: Colors.red));
              } else if (state is ReviewsLoaded) {
                return ProductReviewsWidget(reviews: state.reviews);
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ],
    );
  }
}
