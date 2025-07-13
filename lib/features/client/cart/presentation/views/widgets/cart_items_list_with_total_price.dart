import 'package:flutter/material.dart';
import 'package:swift_mobile_app/features/client/cart/domain/Entities/cart_item_with_product.dart';
import 'package:swift_mobile_app/features/client/cart/presentation/views/widgets/cart_item_list.dart';
import 'package:swift_mobile_app/features/client/cart/presentation/views/widgets/total_price_widget.dart';

class CartItemsListWithTotalPrice extends StatelessWidget {
  const CartItemsListWithTotalPrice({super.key, required this.cartList});
  final List<CartItemWithProductEntity> cartList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: CartItemList(cartList: cartList)),
        TotalPriceWidget(cartList: cartList),
      ],
    );
  }
}