import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift_mobile_app/core/cubits/user_cubit/user_cubit.dart';
import 'package:swift_mobile_app/core/utils/app_colors.dart';
import 'package:swift_mobile_app/core/utils/app_font_styles.dart';
import 'package:swift_mobile_app/core/widgets/product_card_widget.dart';
import 'package:swift_mobile_app/features/seller/home/presentation/cubits/fetch_products_cubit/seller_fetch_products_cubit.dart';
import 'package:swift_mobile_app/features/seller/home/presentation/views/seller_product_details_view.dart';

class SellerHomeViewBody extends StatelessWidget {
  const SellerHomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SellerFetchProductsCubit, FetchProductsState>(
      builder: (context, state) {
        if (state is FetchProductsSuccess) {
          final products = state.products;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      SizedBox(height: 8),
                      Text('منتجاتي', style: AppTextStyles.w400_18),
                      SizedBox(height: 24),
                    ],
                  ),
                ),
                SliverGrid.builder(
                  itemCount: products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 5 / 7,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        final result = await Navigator.pushNamed(
                          context,
                          SellerProductDetailsView.routeName,
                          arguments: products[index],
                        );
                        if (result == true && context.mounted) {
                          final userId =
                              context.read<UserCubit>().currentUser!.sellerId;
                          context
                              .read<SellerFetchProductsCubit>()
                              .fetchProducts(userId);
                        }
                      },
                      child: SellerProductCard(productEntity: products[index]),
                    );
                  },
                ),
              ],
            ),
          );
        } else if (state is FetchProductsFailure) {
          return Center(child: Text('فشل تحميل المنتجات'));
        } else {
          return Center(
            child: CircularProgressIndicator(color: AppColors.primaryColor),
          );
        }
      },
    );
  }
}
