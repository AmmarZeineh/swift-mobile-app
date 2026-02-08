import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swift_mobile_app/core/cubits/user_cubit/user_cubit.dart';
import 'package:swift_mobile_app/core/utils/app_colors.dart';
import 'package:swift_mobile_app/core/utils/app_font_styles.dart';
import 'package:swift_mobile_app/features/client/cart/domain/Entities/cart_item_with_product.dart';
import 'package:swift_mobile_app/features/client/cart/presentation/cubits/cart_item_cubit/cart_item_cubit.dart';
import 'package:swift_mobile_app/features/client/cart/presentation/views/widgets/info_cart_product_button.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key, required this.cartItemWithProductEntity});
  final CartItemWithProductEntity cartItemWithProductEntity;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: CachedNetworkImage(
                imageUrl: cartItemWithProductEntity.product.image[0],
                height: 100.h,
                width: 100.w,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cartItemWithProductEntity.product.name,
                      style: AppTextStyles.w300_14.copyWith(fontSize: 14.sp),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      "${cartItemWithProductEntity.product.price} ل.س",
                      style: AppTextStyles.w700_16.copyWith(
                        color: Colors.grey,
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "الكمية: ${cartItemWithProductEntity.quantity}",
                      style: AppTextStyles.w300_14.copyWith(fontSize: 14.sp),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Column(
              children: [
                IconButton(
                  onPressed: () {
                    final cartItemId = cartItemWithProductEntity.id;
                    final userId = context.read<UserCubit>().currentUser!.id;
                    context.read<CartItemsCubit>().deleteCartItem(
                      cartItemId: cartItemId,
                      userId: userId,
                    );
                  },
                  icon: Icon(
                    FontAwesomeIcons.xmark,
                    size: 20.sp,
                    color: AppColors.primaryColor,
                  ),
                ),
                InfoCartProductButton(
                  cartItemWithProductEntity: cartItemWithProductEntity,
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Divider(
          thickness: 2.h,
          color: Colors.grey.shade300,
          indent: 10.w,
          endIndent: 10.w,
        ),
      ],
    );
  }
}
