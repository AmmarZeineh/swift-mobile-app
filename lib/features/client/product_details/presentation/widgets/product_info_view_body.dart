import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';
import 'package:swift_mobile_app/core/utils/app_font_styles.dart';
import 'package:swift_mobile_app/core/widgets/custom_elevated_button.dart';
import 'package:swift_mobile_app/features/client/home/domain/entities/product_entity.dart';
import 'package:swift_mobile_app/features/client/product_details/domain/entities/attribute_with_value.dart';
import 'package:swift_mobile_app/features/client/product_details/domain/entities/product_attribute_value_entity.dart';
import 'package:swift_mobile_app/features/client/product_details/presentation/cubits/product_attribute_valuecubit/product_attribute_value_cubit.dart';
import 'package:swift_mobile_app/features/client/product_details/presentation/widgets/custom_counter.dart';
import 'package:swift_mobile_app/features/client/product_details/presentation/widgets/product_image.dart';

class ProductInfoViewBody extends StatefulWidget {
  const ProductInfoViewBody({super.key});

  @override
  State<ProductInfoViewBody> createState() => _ProductInfoViewBodyState();
}

class _ProductInfoViewBodyState extends State<ProductInfoViewBody> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final product =
          ModalRoute.of(context)?.settings.arguments as ProductEntity;
      context.read<ProductAttributesCubit>().fetchAttributesWithValues(
        product.id,
        product.categoryId,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)?.settings.arguments as ProductEntity;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Column(
              children: [
                ProductImage(product: product),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.name,
                      style: AppTextStyles.w500_24.copyWith(
                        color: Colors.black,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 30.w),
                      child: Text(
                        '\$ ${product.price}',
                        style: AppTextStyles.w700_30.copyWith(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10.h),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.yellow),
                    SizedBox(width: 10),
                    Text(
                      "4.5",
                      style: AppTextStyles.w700_18.copyWith(
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 160.w),
                    CustomCounter(),
                  ],
                ),
                SizedBox(height: 10.h),
                SizedBox(
                  height: 95,
                  width: 325,
                  child: ReadMoreText(
                    style: AppTextStyles.w400_16.copyWith(
                      color: Colors.black54,
                    ),
                    product.description,
                    trimLines: 5,
                    colorClickableText: Colors.blue,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'قراءة المزيد',
                    trimExpandedText: 'إظهار أقل',
                    moreStyle: AppTextStyles.w400_12.copyWith(
                      color: Colors.black,
                    ),

                    lessStyle: AppTextStyles.w400_12.copyWith(
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  height: 100,
                  child: BlocBuilder<
                    ProductAttributesCubit,
                    ProductAttributesState
                  >(
                    builder: (context, state) {
                      if (state is ProductAttributesSuccess) {
                        return ListView.builder(
                          itemCount: state.attributesWithValues.length,
                          itemBuilder: (context, index) {
                            final item = state.attributesWithValues[index];
                            return SimpleProductAttributeCard(
                              attributeWithValues: item,
                            );
                          },
                        );
                        ;
                      } else if (state is ProductAttributesFailure) {
                        return Text('حدث خطأ ${state.errMessage}');
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      CustomElevatedButton(
                        title: "add to cart",
                        onPressed: () {},
                        width: 250,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ProductAttributeCard extends StatelessWidget {
  final ProductAttributeWithValues attributeWithValues;
  final VoidCallback? onTap;

  const ProductAttributeCard({
    Key? key,
    required this.attributeWithValues,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with attribute name and icon
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        _getAttributeIcon(attributeWithValues.attribute.name),
                        color: Theme.of(context).primaryColor,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        attributeWithValues.attribute.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${attributeWithValues.values.length}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Values section
                if (attributeWithValues.values.isNotEmpty) ...[
                  const Divider(height: 1),
                  const SizedBox(height: 12),
                  _buildValuesSection(context),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildValuesSection(BuildContext context) {
    if (attributeWithValues.values.length == 1) {
      // Single value - display as highlighted text
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Theme.of(context).primaryColor.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Text(
          attributeWithValues.values.first.value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).primaryColor,
          ),
          textAlign: TextAlign.center,
        ),
      );
    } else {
      // Multiple values - display as chips
      return Wrap(
        spacing: 8,
        runSpacing: 8,
        children:
            attributeWithValues.values.map((value) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey[300]!, width: 1),
                ),
                child: Text(
                  value.value,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              );
            }).toList(),
      );
    }
  }

  IconData _getAttributeIcon(String attributeName) {
    final name = attributeName.toLowerCase();

    if (name.contains('لون') || name.contains('color')) {
      return Icons.palette_outlined;
    } else if (name.contains('حجم') || name.contains('size')) {
      return Icons.straighten_outlined;
    } else if (name.contains('وزن') || name.contains('weight')) {
      return Icons.fitness_center_outlined;
    } else if (name.contains('مادة') || name.contains('material')) {
      return Icons.texture_outlined;
    } else if (name.contains('نوع') || name.contains('type')) {
      return Icons.category_outlined;
    } else if (name.contains('موديل') || name.contains('model')) {
      return Icons.inventory_2_outlined;
    } else {
      return Icons.label_outline;
    }
  }
}

// Alternative simpler version
class SimpleProductAttributeCard extends StatelessWidget {
  final ProductAttributeWithValues attributeWithValues;

  const SimpleProductAttributeCard({
    Key? key,
    required this.attributeWithValues,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Attribute name
          Expanded(
            flex: 2,
            child: Text(
              attributeWithValues.attribute.name,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Values
          Expanded(
            flex: 3,
            child: Text(
              attributeWithValues.values.map((v) => v.value).join(', '),
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
          ),
        ],
      ),
    );
  }
}
