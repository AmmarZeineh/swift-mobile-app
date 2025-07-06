import 'package:flutter/material.dart';
import 'package:swift_mobile_app/features/client/home/presentation/views/client_home_view.dart';
import 'package:swift_mobile_app/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:swift_mobile_app/features/seller/add_product/presentation/views/add_product_view.dart';
import 'package:swift_mobile_app/features/seller/auth/presentation/views/seller_login_view.dart';
import 'package:swift_mobile_app/features/seller/auth/presentation/views/seller_signup_view.dart';
import 'package:swift_mobile_app/features/seller/home/domain/entities/product_entity.dart';
import 'package:swift_mobile_app/features/seller/home/presentation/views/seller_home_view.dart';
import 'package:swift_mobile_app/features/seller/home/presentation/views/seller_product_details_view.dart';
import 'package:swift_mobile_app/features/seller/profile/presentation/views/seller_profile_view.dart';

Route<dynamic> onGenerateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case OnboardingView.routeName:
      return MaterialPageRoute(builder: (_) => const OnboardingView());
    case ClientHomeView.routeName:
      return MaterialPageRoute(builder: (_) => const ClientHomeView());
    case SellerLoginView.routeName:
      return MaterialPageRoute(builder: (_) => const SellerLoginView());
    case SellerProductDetailsView.routeName:
      return MaterialPageRoute(
        builder:
            (_) => SellerProductDetailsView(
              productEntity: settings.arguments as ProductEntity,
            ),
      );
    case AddProductView.routeName:
      return MaterialPageRoute(builder: (_) => const AddProductView());
    case SellerProfileView.routeName:
      return MaterialPageRoute(builder: (_) => const SellerProfileView());
    case SellerHomeView.routeName:
      return MaterialPageRoute(builder: (_) => const SellerHomeView());
    case SellerSignupView.routeName:
      return MaterialPageRoute(builder: (_) => const SellerSignupView());
    default:
      return MaterialPageRoute(builder: (_) => const Scaffold());
  }
}
