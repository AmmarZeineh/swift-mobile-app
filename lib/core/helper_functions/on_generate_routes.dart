import 'package:flutter/material.dart';
import 'package:swift_mobile_app/features/client/home/presentation/views/client_home_view.dart';
import 'package:swift_mobile_app/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:swift_mobile_app/features/seller/auth/presentation/views/seller_signup_view.dart';

Route<dynamic> onGenerateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case OnboardingView.routeName:
      return MaterialPageRoute(builder: (_) => const OnboardingView());
    case ClientHomeView.routeName:
      return MaterialPageRoute(builder: (_) => const ClientHomeView());
    case SellerSignupView.routeName:
      return MaterialPageRoute(builder: (_) => const SellerSignupView());
    default:
      return MaterialPageRoute(builder: (_) => const Scaffold());
  }
}
