import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift_mobile_app/core/errors/failure.dart';
import 'package:swift_mobile_app/features/client/cart/domain/Entities/cart_entity.dart';
import 'package:swift_mobile_app/features/client/cart/domain/Entities/cart_item_with_product.dart';
import 'package:swift_mobile_app/features/client/cart/domain/repos/cart_repo.dart';
import 'package:swift_mobile_app/features/client/home/domain/entities/product_entity.dart';

part 'cart_item_state.dart';

class CartItemsCubit extends Cubit<CartItemState> {
  CartItemsCubit(this.cartRepo) : super(CartItemInitial());
  final CartRepo cartRepo;

  Future<void> deleteCartItem({
    required int cartItemId,
    required String userId,
  }) async {
    final result = await cartRepo.deleteCartItem(cartItemId);
    result.fold(
      (l) => emit(CartItemFailure(l.message)),
      (r) => fetchCartItemsWithProducts(userId: userId), // 🟢 إعادة تحميل السلة
    );
  }

  Future<void> fetchCartItemsWithProducts({required String userId}) async {
    emit(CartItemLoading());

    final cartResult = await cartRepo.fetchCartItems(userId: userId);
    if (cartResult.isLeft()) {
      emit(
        CartItemFailure(
          cartResult
              .swap()
              .getOrElse(() => ServerFailure("خطأ غير معروف"))
              .message,
        ),
      );
      return;
    }

    final cartItems = cartResult.getOrElse(() => []);
    final productIds = cartItems.map((e) => e.productId).toSet().toList();

    final productResult = await cartRepo.fetchProductsByIds(productIds);
    if (productResult.isLeft()) {
      emit(
        CartItemFailure(
          productResult
              .swap()
              .getOrElse(() => ServerFailure("خطأ غير معروف"))
              .message,
        ),
      );
      return;
    }

    final products = productResult.getOrElse(() => []);

    final merged = mergeCartWithProducts(
      cartItems: cartItems,
      products: products,
    );

    emit(CartItemSuccess(merged));
  }
}

List<CartItemWithProductEntity> mergeCartWithProducts({
  required List<CartEntity> cartItems,
  required List<ProductEntity> products,
}) {
  // لإنشاء lookup سريع بالـ productId
  final productMap = {for (var product in products) product.id: product};

  // دمج العناصر
  return cartItems
      .where(
        (cart) => productMap.containsKey(cart.productId),
      ) // نتأكد المنتج موجود
      .map((cart) {
        final product = productMap[cart.productId]!;

        return CartItemWithProductEntity(
          id: cart.id,
          createdAt: cart.createdAt,
          userId: cart.userId,
          productId: cart.productId,
          quantity: cart.quantity,
          selectedAttriute: cart.selectedAttribute,
          product: product,
        );
      })
      .toList();
}
