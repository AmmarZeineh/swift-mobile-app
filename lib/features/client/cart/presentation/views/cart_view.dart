import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift_mobile_app/core/services/get_it_service.dart';
import 'package:swift_mobile_app/features/client/cart/domain/repos/cart_repo.dart';
import 'package:swift_mobile_app/features/client/cart/presentation/cubits/cart_item_cubit/cart_item_cubit.dart';
import 'package:swift_mobile_app/features/client/cart/presentation/cubits/check_out_cubit/check_out_cubit.dart';
import 'package:swift_mobile_app/features/client/cart/presentation/views/widgets/cart_view_body.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});
  static const String routeName = 'cart_view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => CartItemsCubit(getIt.get<CartRepo>()),
            ),
            BlocProvider(
              create: (context) => CheckOutCubit(getIt.get<CartRepo>()),
            ),
          ],
          child: CartViewBody(),
        ),
      ),
    );
  }
}
