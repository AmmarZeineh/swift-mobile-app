import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swift_mobile_app/core/cubits/user_cubit/user_cubit.dart';
import 'package:swift_mobile_app/core/services/get_it_service.dart';
import 'package:swift_mobile_app/core/widgets/custom_elevated_button.dart';
import 'package:swift_mobile_app/features/client/cart/domain/repos/cart_repo.dart';
import 'package:swift_mobile_app/features/client/cart/presentation/cubits/cart_item_cubit/cart_item_cubit.dart';
import 'package:swift_mobile_app/features/client/cart/presentation/cubits/check_out_cubit/check_out_cubit.dart';
import 'package:swift_mobile_app/features/client/cart/presentation/views/widgets/cart_items_list_with_total_price.dart';
import 'package:swift_mobile_app/features/client/cart/presentation/views/widgets/checkout_bottom_sheet.dart';
import 'package:swift_mobile_app/core/widgets/secondry_custom_app_bar.dart';

class CartViewBody extends StatefulWidget {
  const CartViewBody({super.key});

  @override
  State<CartViewBody> createState() => _CartViewBodyState();
}

class _CartViewBodyState extends State<CartViewBody> {
  @override
  void initState() {
    context.read<CartItemsCubit>().fetchCartItemsWithProducts(
      userId: context.read<UserCubit>().currentUser!.id,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(text: "My Cart"),
        SizedBox(height: 14),
        Expanded(
          child: BlocBuilder<CartItemsCubit, CartItemState>(
            builder: (context, state) {
              if (state is CartItemSuccess) {
                return CartItemsListWithTotalPrice(cartList: state.carts);
              } else if (state is CartItemFailure) {
                return Text("حدث خطأ");
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),

        SizedBox(height: 20),
        SizedBox(
          height: 60,
          width: 335,
          child: CustomElevatedButton(
            title: "Checkout",
            onPressed: () async {
              final String result = await showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder:
                    (context) => BlocProvider(
                      create: (context) => CheckOutCubit(getIt.get<CartRepo>()),
                      child: CheckoutBottomSheet(),
                    ),
              );

              if (result == 'refresh') {
                context.read<CartItemsCubit>().fetchCartItemsWithProducts(
                  userId: context.read<UserCubit>().currentUser!.id,
                );
              }
            },
          ),
        ),
        SizedBox(height: 30.h),
      ],
    );
  }
}
