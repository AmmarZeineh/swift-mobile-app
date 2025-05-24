import 'package:flutter/material.dart';
import 'package:swift_mobile_app/core/widgets/custom_elevated_button.dart';
import 'package:swift_mobile_app/features/seller/auth/presentation/views/widgets/signup_seller_form.dart';

class SellerSignupViewBody extends StatelessWidget {
  const SellerSignupViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SignupSellerForm(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: CustomElevatedButton(title: 'تسجيل', onPressed: () {}),
          ),
        ],
      ),
    );
  }
}

