import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift_mobile_app/core/services/get_it_service.dart';
import 'package:swift_mobile_app/features/client/order/domain/repo/order_repo.dart';
import 'package:swift_mobile_app/features/client/order/presentation/cubits/cubit/order_cubit.dart';
import 'package:swift_mobile_app/features/client/order/presentation/views/widgets/order_view_body.dart';

class OrderView extends StatelessWidget {
  const OrderView({super.key});
  static const String routeName = 'order';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocProvider(
          create:
              (context) =>
                  OrdersCubit(ordersRepository: getIt.get<OrdersRepo>()),
          child: OrderViewBody(),
        ),
      ),
    );
  }
}
