import 'dart:convert';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swift_mobile_app/core/helper_functions/on_generate_routes.dart';
import 'package:swift_mobile_app/features/onboarding/presentation/views/onboarding_view.dart';

void main() {
  runApp(
    ScreenUtilInit(
      designSize: const Size(375, 812), // أبعاد الشاشة المرجعية في التصميم
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return const SwiftMobileApp(); //  الرئيسي
      },
    ),
  );
}

class SwiftMobileApp extends StatelessWidget {
  const SwiftMobileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: onGenerateRoutes,
      theme: ThemeData(
        progressIndicatorTheme: ProgressIndicatorThemeData(
          color: AppColors.primaryColor,
        ),
        fontFamily: 'duco',
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: OnboardingView.routeName,
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

bool checkIfUserDataExist() {
  return Prefs.getString(clientKey).isNotEmpty;
}

ClientEntity getClientData() {
  return ClientModel.fromJson(jsonDecode(Prefs.getString(clientKey))).toEntity();
}