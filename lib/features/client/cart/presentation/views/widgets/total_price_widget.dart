import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swift_mobile_app/core/utils/app_font_styles.dart';
import 'package:swift_mobile_app/features/client/cart/domain/Entities/cart_item_with_product.dart';

class TotalPriceWidget extends StatelessWidget {
  const TotalPriceWidget({super.key, required this.cartList});
  final List<CartItemWithProductEntity> cartList;

  @override
  Widget build(BuildContext context) {
    log(cartList.toString());
    return SizedBox(
      width: 297.w,
      height: 27.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Total : ",
            style: AppTextStyles.w700_20.copyWith(color: Colors.grey.shade600),
          ),
          Text(
            "\$ ${caculateTotalPrice(cartList).toString()}",
            style: AppTextStyles.w700_20,
          ),
        ],
      ),
    );
  }
}

double caculateTotalPrice(List<CartItemWithProductEntity> cartItems) {
  double totalPrice = 0;
  for (var cartItem in cartItems) {
    totalPrice += cartItem.product.price * cartItem.quantity;
  }
  return totalPrice;
}
