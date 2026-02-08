// app_update_service.dart
import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:swift_mobile_app/core/widgets/custom_elevated_button.dart';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

class AppUpdateService {
  static final _supabase = Supabase.instance.client;

  static Future<void> checkForUpdates(BuildContext context) async {
    try {
      // التأكد من أن context صالح وأن MaterialApp موجود
      if (!context.mounted) return;

      // الحصول على معلومات التطبيق الحالي
      final packageInfo = await PackageInfo.fromPlatform();
      final currentVersion = packageInfo.version;
      final platform = Platform.isAndroid ? 'android' : 'ios';

      // جلب إعدادات التطبيق من السوبابيز
      final response =
          await _supabase
              .from('app_config')
              .select()
              .eq('platform', platform)
              .single();

      final String latestVersion = response['latest_version'];
      final bool forceUpdate = response['force_update'] ?? false;
      final String? updateMessage = response['update_message'];
      final String? storeUrl = response['store_url'];

      // مقارنة الإصدارات
      if (_shouldUpdate(currentVersion, latestVersion)) {
        // التأكد مرة أخرى من أن context صالح قبل إظهار النافذة
        if (context.mounted) {
          await Future.delayed(const Duration(milliseconds: 100));
          if (context.mounted) {
            _showUpdateDialog(
              context,
              forceUpdate: forceUpdate,
              message: updateMessage ?? 'يتوفر إصدار جديد من التطبيق',
              storeUrl: storeUrl,
            );
          }
        }
      }
    } catch (e) {
      log(e.toString());
      // لا تعرض خطأ للمستخدم لأن فحص التحديثات اختياري
    }
  }

  static bool _shouldUpdate(String currentVersion, String latestVersion) {
    // تحويل الإصدارات إلى أرقام للمقارنة
    final current = _parseVersion(currentVersion);
    final latest = _parseVersion(latestVersion);

    for (int i = 0; i < 3; i++) {
      if (latest[i] > current[i]) return true;
      if (latest[i] < current[i]) return false;
    }
    return false;
  }

  static List<int> _parseVersion(String version) {
    final parts = version.split('.');
    return [
      int.tryParse(parts.isNotEmpty ? parts[0] : '0') ?? 0,
      int.tryParse(parts.length > 1 ? parts[1] : '0') ?? 0,
      int.tryParse(parts.length > 2 ? parts[2] : '0') ?? 0,
    ];
  }

  static void _showUpdateDialog(
    BuildContext context, {
    required bool forceUpdate,
    required String message,
    String? storeUrl,
  }) {
    showDialog(
      context: context,
      barrierDismissible: !forceUpdate,
      builder:
          (context) => WillPopScope(
            onWillPop: () async => !forceUpdate,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: AlertDialog(
                title: const Text('تحديث التطبيق'),
                content: Text(message),
                actions: [
                  if (!forceUpdate)
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('لاحقاً'),
                    ),
                  CustomElevatedButton(
                    onPressed: () {
                      if (storeUrl != null && storeUrl.isNotEmpty) {
                        _launchStore(storeUrl);
                      }
                      if (!forceUpdate) {
                        Navigator.of(context).pop();
                      }
                    },
                    title: 'تحميل',
                  ),
                ],
              ),
            ),
          ),
    );
  }

  static Future<void> _launchStore(String url) async {
    try {
      final uri = Uri.parse(url);

      // التحقق من نوع الرابط لتحديد طريقة الفتح المناسبة
      if (url.contains('play.google.com') || url.contains('market://')) {
        // رابط Google Play - محاولة فتح التطبيق أولاً
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      } else if (url.contains('apps.apple.com') ||
          url.contains('itms-apps://')) {
        // رابط App Store - محاولة فتح التطبيق أولاً
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      } else {
        // رابط خارجي - فتح في المتصفح
        if (await canLaunchUrl(uri)) {
          await launchUrl(
            uri,
            mode: LaunchMode.externalApplication,
            webViewConfiguration: const WebViewConfiguration(
              enableJavaScript: true,
              enableDomStorage: true,
            ),
          );
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
