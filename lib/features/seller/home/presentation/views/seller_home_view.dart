import 'package:flutter/material.dart';
import 'package:swift_mobile_app/features/seller/home/presentation/views/widgets/seller_home_view_body.dart';

class SellerHomeView extends StatelessWidget {
  const SellerHomeView({super.key});
  static const routeName = 'seller-home-view';
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: SellerHomeViewBody()));
  }
}
