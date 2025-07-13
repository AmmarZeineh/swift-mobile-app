import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift_mobile_app/core/cubits/user_cubit/user_cubit.dart';
import 'package:swift_mobile_app/core/widgets/secondry_custom_app_bar.dart';
import 'package:swift_mobile_app/features/client/order/presentation/cubits/cubit/order_cubit.dart';
import 'package:swift_mobile_app/features/client/order/presentation/views/widgets/order_list_view.dart';

class OrderViewBody extends StatefulWidget {
  const OrderViewBody({super.key});

  @override
  State<OrderViewBody> createState() => _OrderViewBodyState();
}

class _OrderViewBodyState extends State<OrderViewBody> {
  @override
  void initState() {
    super.initState();
    var userId = context.read<UserCubit>().currentUser!.id;
    context.read<OrdersCubit>().loadUserOrders(userId);
  }

  @override
  Widget build(BuildContext context) {
    final String userId = context.read<UserCubit>().currentUser!.id;

    return Column(
      children: [
        CustomAppBar(text: "طلباتي", isArrowActive: false),
        SizedBox(height: 20),
        Expanded(
          child: BlocBuilder<OrdersCubit, OrdersState>(
            builder: (context, state) {
              return RefreshIndicator(
                onRefresh: () async {
                  await context.read<OrdersCubit>().loadUserOrders(userId);
                },
                child: () {
                  if (state is OrdersLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is OrdersError) {
                    return ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        const SizedBox(height: 200),
                        Center(child: Text('خطأ: ${state.message}')),
                      ],
                    );
                  } else if (state is OrdersLoaded) {
                    if (state.orders.isEmpty) {
                      return ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: const [
                          SizedBox(height: 200),
                          Center(child: Text('لا توجد طلبات')),
                        ],
                      );
                    }

                    return OrdersListView(userId: userId, orders: state.orders);
                  }

                  // الحالة الافتراضية
                  return ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: const [
                      SizedBox(height: 200),
                      Center(child: Text('لا توجد بيانات')),
                    ],
                  );
                }(),
              );
            },
          ),
        ),
      ],
    );
  }
}
