import 'package:flutter/material.dart';
import 'package:swift_mobile_app/features/client/cart/domain/Entities/cart_item_with_product.dart';
import 'package:swift_mobile_app/features/client/cart/presentation/views/widgets/cart_item.dart';

class CartItemList extends StatelessWidget {
  const CartItemList({super.key, required this.cartList});
  final List<CartItemWithProductEntity> cartList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cartList.length,
      itemBuilder:
          (context, index) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CartItem(
                cartItemWithProductEntity: cartList[index],
              ),
            ),
          ),
    );
  }
}