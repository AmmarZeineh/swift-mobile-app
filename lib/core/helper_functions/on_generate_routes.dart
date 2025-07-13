import 'package:flutter/material.dart';
import 'package:swift_mobile_app/features/client/auth/presentation/views/client_login_view.dart';
import 'package:swift_mobile_app/features/client/auth/presentation/views/client_sign_up_view.dart';
import 'package:swift_mobile_app/features/client/cart/presentation/views/cart_view.dart';
import 'package:swift_mobile_app/features/client/home/domain/entities/product_entity.dart';
import 'package:swift_mobile_app/features/client/home/presentation/views/client_home_view.dart';
import 'package:swift_mobile_app/features/client/home/presentation/views/search_view.dart';
import 'package:swift_mobile_app/features/client/order/data/models/order_item_model.dart';
import 'package:swift_mobile_app/features/client/order/domain/entities/order_entity.dart';
import 'package:swift_mobile_app/features/client/order/presentation/views/order_items_view.dart';
import 'package:swift_mobile_app/features/client/product_details/presentation/views/product_details_view.dart';
import 'package:swift_mobile_app/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:swift_mobile_app/features/seller/auth/presentation/views/seller_signup_view.dart';

Route<dynamic> onGenerateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case OnboardingView.routeName:
      return MaterialPageRoute(builder: (_) => const OnboardingView());
    case ClientHomeView.routeName:
      return MaterialPageRoute(builder: (_) => ClientHomeView());
    case SellerSignupView.routeName:
      return MaterialPageRoute(builder: (_) => const SellerSignupView());
    case ClientProductInfoView.routName: // تم إصلاح routName إلى routeName
      final product =
          settings.arguments as ProductEntity; // استخراج الـ arguments
      return MaterialPageRoute(
        builder:
            (_) => ClientProductInfoView(product: product), // تمرير الـ product
      );
    case ClientLoginView.routeName:
      return MaterialPageRoute(builder: (_) => const ClientLoginView());
    case CartView.routeName:
      return MaterialPageRoute(builder: (_) => const CartView());
    case ClientSignupView.routeName:
      return MaterialPageRoute(builder: (_) => const ClientSignupView());
    case SearchView.routeName:
      return MaterialPageRoute(builder: (_) => const SearchView());

    case OrderItemsView.routeName:
      final arg = settings.arguments as List<dynamic>;
      final items = arg[0] as List<OrderItemModel>;
      final order = arg[1] as OrderEntity;
      return MaterialPageRoute(
        builder: (_) => OrderItemsView(items: items, orderEntity: order),
      );

    default:
      return MaterialPageRoute(builder: (_) => const Scaffold());
  }
}
