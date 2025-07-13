import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:swift_mobile_app/app_keys.dart';
import 'package:swift_mobile_app/constats.dart';
import 'package:swift_mobile_app/core/cubits/user_cubit/user_cubit.dart';
import 'package:swift_mobile_app/core/helper_functions/on_generate_routes.dart';
import 'package:swift_mobile_app/core/services/custom_bloc_observer.dart';
import 'package:swift_mobile_app/core/services/get_it_service.dart';
import 'package:swift_mobile_app/core/services/shared_preference_singletone.dart';
import 'package:swift_mobile_app/features/client/auth/data/models/client_model.dart';
import 'package:swift_mobile_app/features/client/auth/domain/entities/client_entity.dart';
import 'package:swift_mobile_app/features/client/home/presentation/views/client_home_view.dart';
import 'package:swift_mobile_app/features/onboarding/presentation/views/onboarding_view.dart';

void main() async {
  await Supabase.initialize(url: AppKeys.url, anonKey: AppKeys.annonKey);
  setupLocator();
  await ScreenUtil.ensureScreenSize();
  await Prefs.init();
   Bloc.observer = CustomBlocObserver();

  final bool hasUser = checkIfUserDataExist();
  final ClientEntity? user = hasUser ? getClientData() : null;

  runApp(
    ScreenUtilInit(
      designSize: const Size(375, 812), 
     builder: (_, __) {
        return BlocProvider(
          create: (_) {
            final cubit = UserCubit();
            if (user != null) cubit.setUser(user);
            return cubit;
          },
          child: const SwiftMobileApp(),
        );
      },
    ),
  );
}

class SwiftMobileApp extends StatelessWidget {
  const SwiftMobileApp({super.key});

  // This widget is the root of your application.
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
      initialRoute:   userState is UserLoaded
              ? ClientHomeView.routeName
              : OnboardingView.routeName,
    );
  }
}

bool checkIfUserDataExist() {
  return Prefs.getString(clientKey).isNotEmpty;
}

ClientEntity getClientData() {
  return ClientModel.fromJson(jsonDecode(Prefs.getString(clientKey))).toEntity();
}