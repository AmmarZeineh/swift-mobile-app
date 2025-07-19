import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    super.initState();
    context.read<ProductAttributesCubit>().fetchAttributesWithValues(
      widget.product.categoryId,
      widget.product.id,
    );
    context.read<ReviewsCubit>().fetchReviews(widget.product.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buildBottomButton(),
      body: _buildBody(),
    );
  }

  Widget _buildBottomButton() {
    return Padding(
      padding: const EdgeInsets.all(16),
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
            padding: const EdgeInsets.symmetric(vertical: 12),
            title: state is AddToCartLoading ? "جاري الإضافة" : "اضافة للسلة",
            onPressed: _handleAddToCart,
          );
        },
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProductImage(product: widget.product),
          const SizedBox(height: 24),
          _buildProductHeader(),
          const SizedBox(height: 16),
          _buildProductRating(),
          const SizedBox(height: 16),
          _buildProductDescription(),
          const SizedBox(height: 24),
          _buildProductAttributes(),
          const SizedBox(height: 24),
          _buildProductReviews(),
        ],
      ),
    );
  }

  Widget _buildProductHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            widget.product.name,
            style: AppTextStyles.w500_24.copyWith(color: Colors.black),
          ),
        ),
        const SizedBox(width: 16),
        Text(
          '\$ ${widget.product.price}',
          style: AppTextStyles.w700_30.copyWith(color: Colors.black),
        ),
      ],
    );
  }

  Widget _buildProductRating() {
    return Row(
      children: [
        const Icon(Icons.star, color: Colors.orange),
        const SizedBox(width: 8),
        Text(
          widget.product.rating.toString(),
          style: AppTextStyles.w700_18.copyWith(color: Colors.black),
        ),
        const Spacer(),
        CustomCounter(key: counterKey),
      ],
    );
  }

  Widget _buildProductDescription() {
    return CustomText(widget: widget);
  }

  Widget _buildProductAttributes() {
    return BlocBuilder<ProductAttributesCubit, ProductAttributesState>(
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
          return Center(
            child: Text(
              'حدث خطأ: ${state.errMessage}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buildProductReviews() {
    return BlocBuilder<ReviewsCubit, ReviewsState>(
      builder: (context, state) {
        if (state is ReviewsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ReviewsError) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(color: Colors.red),
            ),
          );
        } else if (state is ReviewsLoaded) {
          return ProductReviewsWidget(reviews: state.reviews);
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  void _handleAddToCart() {
    final quantity = counterKey.currentState?.count ?? 1;

    // فحص المواصفات المطلوبة
    final cubitState = context.read<ProductAttributesCubit>().state;
    if (cubitState is! ProductAttributesSuccess) return;

    final requiredAttributes =
        cubitState.attributesWithValues
            .where((e) => e.attribute.isRequired)
            .map((e) => e.attribute.name)
            .toList();

    final allSelected = requiredAttributes.every(
      (key) => selectedAttributes.containsKey(key),
    );

    if (!allSelected) {
      showErrorMessage("يرجى اختيار جميع المواصفات المطلوبة", context);
      return;
    }

    // تجميع المواصفات
    final selectedSummary = selectedAttributes.entries
        .map((e) => "${e.key}: ${e.value}")
        .join(", ");

    // إضافة للسلة
    context.read<AddToCartCubit>().addToCart(
      userId: context.read<UserCubit>().currentUser!.id,
      product: widget.product,
      quantity: quantity,
      selectedAttributesSummary: selectedSummary,
    );
  }
}
