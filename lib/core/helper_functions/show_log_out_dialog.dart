import 'package:flutter/material.dart';
import 'package:swift_mobile_app/constants.dart';
import 'package:swift_mobile_app/core/services/get_it_service.dart';
import 'package:swift_mobile_app/core/services/shared_preference_singletone.dart';
import 'package:swift_mobile_app/core/services/supabase_auth_service.dart';
import 'package:swift_mobile_app/features/onboarding/presentation/views/onboarding_view.dart';

void showLogoutDialog(BuildContext context) {
  var supabaseAuth = getIt.get<SupabaseAuthService>();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          title: const Text('تسجيل الخروج'),
          content: const Text('هل أنت متأكد من تسجيل الخروج؟'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('إلغاء'),
            ),
            TextButton(
              onPressed: () async {
                await supabaseAuth.signOut();
                await Prefs.remove(sellerKey);

                if (context.mounted) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    OnboardingView.routeName,
                    (route) => false,
                  );
                }
              },
              child: const Text(
                'تسجيل الخروج',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      );
    },
  );
}
