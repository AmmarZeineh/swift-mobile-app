import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift_mobile_app/core/helper_functions/snack_bars.dart';
import 'package:swift_mobile_app/core/helper_functions/show_edit_dialog.dart';
import 'package:swift_mobile_app/core/utils/app_colors.dart';
import 'package:swift_mobile_app/core/utils/app_font_styles.dart';
import 'package:swift_mobile_app/features/seller/home/domain/entities/product_entity.dart';
import 'package:swift_mobile_app/features/seller/home/presentation/cubits/edit_product_details_cubit/cubit/edit_product_details_cubit_cubit.dart';
import 'package:swift_mobile_app/features/seller/home/presentation/cubits/fetch_product_reviews_cubit/cubit/fetch_product_reviews_cubit.dart';
import 'package:swift_mobile_app/features/seller/home/presentation/cubits/product_attributes_cubit/product_attributes_cubit.dart';
import 'package:swift_mobile_app/features/seller/home/presentation/views/widgets/product_details_attribute_values_section.dart';
import 'package:swift_mobile_app/features/seller/home/presentation/views/widgets/product_details_row.dart';
import 'package:swift_mobile_app/features/seller/home/presentation/views/widgets/product_review_widget.dart';

class SellerProductDetailsViewBody extends StatefulWidget {
  const SellerProductDetailsViewBody({super.key, required this.productEntity});
  final ProductEntity productEntity;

  @override
  State<SellerProductDetailsViewBody> createState() =>
      _SellerProductDetailsViewBodyState();
}

class _SellerProductDetailsViewBodyState
    extends State<SellerProductDetailsViewBody>
    with SingleTickerProviderStateMixin {
  late ProductEntity currentProduct;
  bool _isExpanded = false;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    currentProduct = widget.productEntity;

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductAttributesCubit>().fetchAttributesWithValues(
        widget.productEntity.categoryId,
        widget.productEntity.id,
      );
      context.read<FetchProductReviewsCubit>().fetchProductReviews(
        widget.productEntity,
      );
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<
      EditProductDetailsCubitCubit,
      EditProductDetailsCubitState
    >(
      listener: (context, state) {
        if (state is EditProductDetailsCubitSuccess) {
          setState(() {
            currentProduct = state.productEntity;
          });
          showSuccessMessage('تم تحديث بيانات المنتج بنجاح', context);
        } else if (state is EditProductDetailsCubitFailure) {
          showErrorMessage(
            'فشل في تحديث البيانات: ${state.errMessage}',
            context,
          );
        }
      },
      child: SingleChildScrollView(
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

              // الصورة والاسم (يظهران دائماً)
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CachedNetworkImage(imageUrl: currentProduct.image[0]),
              ),
              SizedBox(height: 16),

              ProductDetailsRow(
                title: 'الاسم',
                value: currentProduct.name,
                onPressed: () {
                  showEditDialog(
                    currentProduct,
                    context,
                    'الاسم',
                    currentProduct.name,
                    (value) async {
                      await context
                          .read<EditProductDetailsCubitCubit>()
                          .updateProduct(currentProduct, {'name': value});
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    },
                  );
                },
              ),

              ProductDetailsRow(
                title: 'الوصف',
                value: currentProduct.description,
                onPressed: () {
                  showEditDialog(
                    currentProduct,
                    context,
                    'الوصف',
                    currentProduct.description,
                    (value) async {
                      await context
                          .read<EditProductDetailsCubitCubit>()
                          .updateProduct(currentProduct, {
                            'description': value,
                          });
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    },
                  );
                },
              ),

              SizedBox(height: 16),

              // زر عرض باقي التفاصيل
              GestureDetector(
                onTap: _toggleExpansion,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AnimatedRotation(
                        turns: _isExpanded ? 0.5 : 0,
                        duration: Duration(milliseconds: 300),
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      Text(
                        _isExpanded ? 'إخفاء التفاصيل' : 'عرض باقي التفاصيل',
                        style: AppTextStyles.w400_16.copyWith(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // باقي التفاصيل (قابلة للطي)
              SizeTransition(
                sizeFactor: _animation,
                child: Column(
                  children: [
                    SizedBox(height: 16),

                    ProductDetailsRow(
                      title: 'السعر',
                      value: '${currentProduct.price.toString()}\$',
                      onPressed: () {
                        showEditDialog(
                          currentProduct,
                          context,
                          'السعر',
                          currentProduct.price.toString(),
                          (value) async {
                            await context
                                .read<EditProductDetailsCubitCubit>()
                                .updateProduct(currentProduct, {
                                  'price':
                                      double.tryParse(value) ??
                                      currentProduct.price,
                                });
                            if (context.mounted) {
                              Navigator.pop(context);
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
                          currentProduct,
                          context,
                          'العدد في المخزون',
                          currentProduct.stock.toString(),
                          (value) async {
                            await context
                                .read<EditProductDetailsCubitCubit>()
                                .updateProduct(currentProduct, {
                                  'stock':
                                      int.tryParse(value) ??
                                      currentProduct.stock,
                                });
                            if (context.mounted) {
                              Navigator.pop(context);
                            }
                          },
                        );
                      },
                    ),
                    ProductDetailsAttributeValuesSection(
                      currentProduct: currentProduct,
                    ),
                  ],
                ),
              ),
              BlocBuilder<FetchProductReviewsCubit, FetchProductReviewsState>(
                builder: (context, state) {
                  if (state is FetchProductReviewsSuccess) {
                    return ProductReviewsWidget(reviews: state.reviews);
                  }
                  return ProductReviewsWidget(reviews: []);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
