import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:swift_mobile_app/app_keys.dart';
import 'package:swift_mobile_app/constants.dart';
import 'package:swift_mobile_app/core/cubits/user_cubit.dart';
import 'package:swift_mobile_app/core/helper_functions/on_generate_routes.dart';
import 'package:swift_mobile_app/core/services/custom_bloc_observer.dart';
import 'package:swift_mobile_app/core/services/get_it_service.dart';
import 'package:swift_mobile_app/core/services/shared_preference_singletone.dart';
import 'package:swift_mobile_app/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:swift_mobile_app/features/seller/auth/data/models/seller_model.dart';
import 'package:swift_mobile_app/features/seller/auth/domain/entity/seller_entity.dart';
import 'package:swift_mobile_app/features/seller/home/domain/repos/seller_home_repo.dart';
import 'package:swift_mobile_app/features/seller/home/presentation/cubits/delete_product_cubit/delete_product_cubit.dart';
import 'package:swift_mobile_app/features/seller/home/presentation/cubits/edit_product_details_cubit/cubit/edit_product_details_cubit_cubit.dart';
import 'package:swift_mobile_app/features/seller/home/presentation/cubits/fetch_product_reviews_cubit/cubit/fetch_product_reviews_cubit.dart';
import 'package:swift_mobile_app/features/seller/home/presentation/cubits/fetch_products_cubit/fetch_products_cubit.dart';
import 'package:swift_mobile_app/features/seller/home/presentation/cubits/product_attributes_cubit/product_attributes_cubit.dart';
import 'package:swift_mobile_app/features/seller/home/presentation/views/seller_home_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: AppKeys.url, anonKey: AppKeys.annon);
  setupLocator();
  await Prefs.init();
  Bloc.observer = CustomBlocObserver();

  final bool hasUser = checkIfUserDataExist();

  final SellerEntity? user = hasUser ? getSellerData() : null;

  runApp(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (_, __) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) {
                final cubit = UserCubit();
                if (user != null) cubit.setUser(user);
                return cubit;
              },
            ),
            BlocProvider(
              create:
                  (context) => FetchProductsCubit(getIt.get<SellerHomeRepo>()),
            ),
            BlocProvider(
              create:
                  (context) => DeleteProductCubit(getIt.get<SellerHomeRepo>()),
            ),
            BlocProvider(
              create:
                  (context) =>
                      ProductAttributesCubit(getIt.get<SellerHomeRepo>()),
            ),
            BlocProvider(
              create:
                  (context) =>
                      EditProductDetailsCubitCubit(getIt.get<SellerHomeRepo>()),
            ),
            BlocProvider(
              create:
                  (context) =>
                      FetchProductReviewsCubit(getIt.get<SellerHomeRepo>()),
            ),
          ],
          child: const SwiftMobileApp(),
        );
      },
    ),
  );
}

class SwiftMobileApp extends StatelessWidget {
  const SwiftMobileApp({super.key});

  @override
  Widget build(BuildContext context) {
    final userState = context.watch<UserCubit>().state;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: onGenerateRoutes,
      theme: ThemeData(
        fontFamily: 'duco',
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute:
          userState is UserLoaded
              ? SellerHomeView.routeName
              : OnboardingView.routeName,
    );
  }
}

bool checkIfUserDataExist() {
  return Prefs.getString(sellerKey).isNotEmpty;
}

SellerEntity getSellerData() {
  return SellerModel.fromJson(
    jsonDecode(Prefs.getString(sellerKey)),
  ).toEntity();
}
