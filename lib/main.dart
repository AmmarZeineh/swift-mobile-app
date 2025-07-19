import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:swift_mobile_app/app_keys.dart';
import 'package:swift_mobile_app/constants.dart';
import 'package:swift_mobile_app/core/cubits/user_cubit/user_cubit.dart';
import 'package:swift_mobile_app/core/helper_functions/on_generate_routes.dart';
import 'package:swift_mobile_app/core/repos/image_repo/image_repo.dart';
import 'package:swift_mobile_app/core/repos/profile_repo/profile_repo.dart';
import 'package:swift_mobile_app/core/services/custom_bloc_observer.dart';
import 'package:swift_mobile_app/core/services/get_it_service.dart';
import 'package:swift_mobile_app/core/services/shared_preference_singletone.dart';
import 'package:swift_mobile_app/core/utils/app_colors.dart';

import 'package:swift_mobile_app/features/client/auth/data/models/client_model.dart';
import 'package:swift_mobile_app/features/client/home/presentation/views/client_home_view.dart';

import 'package:swift_mobile_app/features/seller/auth/data/models/seller_model.dart';
import 'package:swift_mobile_app/features/seller/home/presentation/cubits/fetch_products_cubit/seller_fetch_products_cubit.dart';
import 'package:swift_mobile_app/features/seller/home/presentation/views/seller_home_view.dart';

import 'package:swift_mobile_app/features/seller/add_product/domain/repos/add_product_repo.dart';
import 'package:swift_mobile_app/features/seller/add_product/presentation/cubits/fetch_categories_cubit/fetch_categories_cubit.dart';
import 'package:swift_mobile_app/features/seller/home/domain/repos/seller_home_repo.dart';
import 'package:swift_mobile_app/features/seller/home/presentation/cubits/delete_product_cubit/delete_product_cubit.dart';
import 'package:swift_mobile_app/features/seller/home/presentation/cubits/edit_product_details_cubit/cubit/edit_product_details_cubit_cubit.dart';
import 'package:swift_mobile_app/features/seller/home/presentation/cubits/fetch_product_reviews_cubit/cubit/fetch_product_reviews_cubit.dart';
import 'package:swift_mobile_app/features/seller/home/presentation/cubits/product_attributes_cubit/product_attributes_cubit.dart';
import 'package:swift_mobile_app/core/cubits/edit_profile_details_cubit/edit_profile_details_cubit.dart';

import 'package:swift_mobile_app/features/onboarding/presentation/views/onboarding_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(url: AppKeys.url, anonKey: AppKeys.annon);
  await ScreenUtil.ensureScreenSize();
  setupLocator();
  await Prefs.init();
  Bloc.observer = CustomBlocObserver();

  dynamic user;
  String userRole = '';

  final bool hasClient = Prefs.getString(clientKey).isNotEmpty;
  final bool hasSeller = Prefs.getString(sellerKey).isNotEmpty;

  if (hasClient) {
    user =
        ClientModel.fromJson(jsonDecode(Prefs.getString(clientKey))).toEntity();
    userRole = user.role;
  } else if (hasSeller) {
    user =
        SellerModel.fromJson(jsonDecode(Prefs.getString(sellerKey))).toEntity();
    userRole = user.role;
  }

  runApp(
    BlocProvider(
      create: (_) => AppSessionCubit()..setUser(user, userRole),
      child: const SwiftMobileApp(),
    ),
  );
}

// ==========================================
// AppSessionCubit (أضفه بنفس هذا الملف أو ملف منفصل)
// ==========================================

class AppSessionState {
  final dynamic user;
  final String userRole;

  AppSessionState({this.user, this.userRole = ''});

  bool get isSeller => userRole == 'seller';
  bool get isClient => userRole == 'client';
}

class AppSessionCubit extends Cubit<AppSessionState> {
  AppSessionCubit() : super(AppSessionState());

  void setUser(dynamic user, String role) {
    emit(AppSessionState(user: user, userRole: role));
  }

  void logout() {
    emit(AppSessionState());
  }
}

// ==========================================
// SwiftMobileApp
// ==========================================

class SwiftMobileApp extends StatelessWidget {
  const SwiftMobileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) {
        return BlocBuilder<AppSessionCubit, AppSessionState>(
          builder: (context, state) {
            final user = state.user;
            final userRole = state.userRole;
            final isSeller = state.isSeller;

            return MultiBlocProvider(
              providers: [
                BlocProvider(create: (_) => UserCubit()..setUser(user)),
                if (isSeller) ...[
                  BlocProvider(
                    create:
                        (_) =>
                            FetchCategoriesCubit(getIt.get<AddProductRepo>())
                              ..fetchCategories(),
                  ),
                  BlocProvider(
                    create:
                        (_) => SellerFetchProductsCubit(
                          getIt.get<SellerHomeRepo>(),
                        )..fetchProducts(user.sellerId),
                  ),
                  BlocProvider(
                    create:
                        (_) =>
                            EditProfileDetailsCubit(getIt.get<ProfileRepo>()),
                  ),
                  BlocProvider(
                    create:
                        (_) => DeleteProductCubit(
                          getIt.get<SellerHomeRepo>(),
                          getIt.get<ImageRepo>(),
                        ),
                  ),
                  BlocProvider(
                    create:
                        (_) =>
                            ProductAttributesCubit(getIt.get<SellerHomeRepo>()),
                  ),
                  BlocProvider(
                    create:
                        (_) => EditProductDetailsCubitCubit(
                          getIt.get<SellerHomeRepo>(),
                        ),
                  ),
                  BlocProvider(
                    create:
                        (_) => FetchProductReviewsCubit(
                          getIt.get<SellerHomeRepo>(),
                        ),
                  ),
                ],
              ],
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  onGenerateRoute: onGenerateRoutes,
                  theme: ThemeData(
                    fontFamily: 'duco',
                    scaffoldBackgroundColor: Colors.white,
                    progressIndicatorTheme: const ProgressIndicatorThemeData(
                      color: AppColors.primaryColor,
                    ),
                  ),
                  initialRoute: _getInitialRoute(user, userRole),
                ),
              ),
            );
          },
        );
      },
    );
  }

  String _getInitialRoute(dynamic user, String role) {
    if (user == null) return OnboardingView.routeName;
    switch (role) {
      case 'seller':
        return SellerHomeView.routeName;
      case 'client':
        return ClientHomeView.routeName;
      default:
        return OnboardingView.routeName;
    }
  }
}
