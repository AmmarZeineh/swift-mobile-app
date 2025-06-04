import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:swift_mobile_app/app_keys.dart';
import 'package:swift_mobile_app/core/helper_functions/on_generate_routes.dart';
import 'package:swift_mobile_app/core/services/custom_bloc_observer.dart';
import 'package:swift_mobile_app/core/services/get_it_service.dart';
import 'package:swift_mobile_app/features/onboarding/presentation/views/onboarding_view.dart';

void main() async {
  await Supabase.initialize(url: AppKeys.url, anonKey: AppKeys.annon);
  setupLocator();
  Bloc.observer = CustomBlocObserver();
  runApp(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return const SwiftMobileApp();
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
        fontFamily: 'duco',
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: OnboardingView.routeName,
    );
  }
}
