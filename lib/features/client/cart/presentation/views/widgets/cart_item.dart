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
    return SizedBox(
      height: 124.h,
      width: 334.w,
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(12),
                child: CachedNetworkImage(
                  imageUrl: cartItemWithProductEntity.product.image[0],
                  height: 100,
                  width: 100,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(width: 20),
              SizedBox(
                width: 130,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      cartItemWithProductEntity.product.name,
                      style: AppTextStyles.w300_14,
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      "\$ ${cartItemWithProductEntity.product.price}",
                      style: AppTextStyles.w700_16.copyWith(color: Colors.grey),
                    ),
                    Text(
                      "qauntity : ${cartItemWithProductEntity.quantity.toString()}",
                      style: AppTextStyles.w300_14,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 55.w),
              Column(
                children: [
                  IconButton(
                    onPressed: () {
                      final int cartItemId = cartItemWithProductEntity.id;
                      final userId = context.read<UserCubit>().currentUser!.id;

                      context.read<CartItemsCubit>().deleteCartItem(
                        cartItemId: cartItemId,
                        userId: userId,
                      );
                    },
                    icon: Icon(
                      FontAwesomeIcons.xmark,
                      size: 24.sp,
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
          SizedBox(height: 12),
          SizedBox(
            width: 300.w,
            child: Divider(thickness: 3, color: Colors.grey.shade200),
          ),
        ],
      ),
    );
  }
}
