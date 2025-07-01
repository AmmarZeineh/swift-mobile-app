import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swift_mobile_app/core/cubits/user_cubit.dart';
import 'package:swift_mobile_app/core/utils/app_font_styles.dart';
import 'package:swift_mobile_app/core/widgets/product_card_widget.dart';
import 'package:swift_mobile_app/features/seller/home/presentation/cubits/fetch_products_cubit/fetch_products_cubit.dart';
import 'package:swift_mobile_app/features/seller/home/presentation/views/seller_product_details_view.dart';

class SellerHomeViewBody extends StatelessWidget {
  const SellerHomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchProductsCubit, FetchProductsState>(
      builder: (context, state) {
        if (state is FetchProductsSuccess) {
          final products = state.products;
          return Column(
            children: [
              SizedBox(height: 8),
              Text('منتجاتي', style: AppTextStyles.w400_18),
              SizedBox(
                height: 732.h,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 24,
                  ),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 5.w / 7.3.h,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: products.length,
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
                            context.read<FetchProductsCubit>().fetchProducts(
                              userId,
                            );
                          }
                        },
                        child: ProductCard(productEntity: products[index]),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        } else if (state is FetchProductsFailure) {
          return Center(child: Text('فشل تحميل المنتجات'));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
