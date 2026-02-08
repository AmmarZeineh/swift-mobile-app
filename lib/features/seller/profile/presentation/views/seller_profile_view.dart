import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift_mobile_app/core/cubits/user_cubit/user_cubit.dart';
import 'package:swift_mobile_app/features/seller/profile/presentation/views/widgets/seller_profile_view_body.dart';

class SellerProfileView extends StatelessWidget {
  const SellerProfileView({super.key});
  static const routeName = 'Seller-Profile-View';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SellerProfileViewBody(
          sellerEntity: context.read<UserCubit>().currentUser!,
        ),
      ),
    );
  }
}
