import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swift_mobile_app/core/utils/app_colors.dart';

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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'duco',
        scaffoldBackgroundColor: AppColors.backgroundColor,
      ),
      home: Scaffold(body: Text('data')),
    );
  }
}
