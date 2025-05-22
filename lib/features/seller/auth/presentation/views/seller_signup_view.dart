import 'package:flutter/material.dart';
import 'package:swift_mobile_app/features/seller/auth/presentation/views/widgets/seller_signup_view_body.dart';

class SellerSignupView extends StatelessWidget {
  const SellerSignupView({super.key});
  static const routeName = 'seller-signup-view';
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SellerSignupViewBody());
  }
}
