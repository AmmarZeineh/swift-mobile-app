import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift_mobile_app/core/widgets/custom_elevated_button.dart';
import 'package:swift_mobile_app/core/cubits/user_cubit.dart';
import 'package:swift_mobile_app/features/seller/home/presentation/cubits/fetch_products_cubit/fetch_products_cubit.dart';
import 'package:swift_mobile_app/features/seller/home/presentation/views/widgets/seller_home_view_body.dart';

class SellerHomeView extends StatelessWidget {
  const SellerHomeView({super.key});
  static const routeName = 'seller-home-view';

  @override
  Widget build(BuildContext context) {
    context.read<FetchProductsCubit>().fetchProducts(
      context.read<UserCubit>().currentUser!.sellerId,
    );
    return Scaffold(
      body: SafeArea(child: SellerHomeViewBody()),
      floatingActionButton: CustomElevatedButton(
        title: 'اضافة منتج',
        onPressed: () {},
        padding: EdgeInsets.all(16),
      ),
    );
  }
}

// // باقي الكود يبقى نفسه
// class HomeViewBodyBlocConsumer extends StatelessWidget {
//   const HomeViewBodyBlocConsumer({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<FetchProductsCubit, FetchProductsState>(
//       builder: (context, state) {
//         if (state is FetchProductsFailure) {
//           errorSnackBar(context, state.errMessage);
//         }
//         if (state is FetchProductsSuccess) {
//           return SellerHomeViewBody(products: state.products);
//         }
//         return ModalProgressHUD(
//           inAsyncCall: state is FetchProductsLoading,
//           child: SellerHomeViewBody(products: []),
//         );
//       },
//     );
//   }
// }
