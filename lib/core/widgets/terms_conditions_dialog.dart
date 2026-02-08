import 'package:flutter/material.dart';
import 'package:swift_mobile_app/core/utils/app_colors.dart';
import 'package:swift_mobile_app/core/utils/app_font_styles.dart';

class TermsConditionsDialog extends StatelessWidget {
  const TermsConditionsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close, color: Colors.white),
                  ),
                  Text(
                    'الشروط والأحكام',
                    style: AppTextStyles.w600_18.copyWith(color: Colors.white),
                  ),
                  SizedBox(width: 40), // للتوازن في التخطيط
                ],
              ),
            ),

            // Content
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _buildSection(
                        'مقدمة',
                        'مرحباً بك في تطبيق Swift. باستخدامك لهذا التطبيق، فإنك توافق على الالتزام بهذه الشروط والأحكام والامتثال لها.',
                      ),

                      _buildSection(
                        'استخدام التطبيق',
                        '• يجب أن يكون عمرك 13 عاماً على الأقل لاستخدام هذا التطبيق\n'
                            '• يجب تقديم معلومات صحيحة ودقيقة عند التسجيل\n'
                            '• أنت مسؤول عن الحفاظ على سرية بيانات حسابك\n'
                            '• لا يُسمح باستخدام التطبيق لأي أغراض غير قانونية',
                      ),

                      _buildSection(
                        'الخصوصية وحماية البيانات',
                        '• نحن ملتزمون بحماية خصوصيتك وبياناتك الشخصية\n'
                            '• يتم جمع البيانات وفقاً لسياسة الخصوصية الخاصة بنا\n'
                            '• لن نشارك معلوماتك مع أطراف ثالثة دون موافقتك\n'
                            '• يمكنك طلب حذف بياناتك في أي وقت',
                      ),

                      _buildSection(
                        'المسؤوليات والالتزامات',
                        '• أنت مسؤول عن جميع الأنشطة التي تتم تحت حسابك\n'
                            '• يجب عدم انتهاك حقوق الملكية الفكرية للآخرين\n'
                            '• يُمنع نشر محتوى مسيء أو غير مناسب\n'
                            '• نحتفظ بالحق في إيقاف أو حذف الحسابات المخالفة',
                      ),

                      _buildSection(
                        'الدفع والاسترداد',
                        '• جميع المدفوعات تتم من خلال وسائل الدفع المعتمدة\n'
                            '• يمكن طلب الاسترداد وفقاً لسياسة الاسترداد\n'
                            '• الأسعار قابلة للتغيير دون إشعار مسبق\n'
                            '• أنت مسؤول عن دفع جميع الضرائب المطلوبة',
                      ),

                      _buildSection(
                        'إخلاء المسؤولية',
                        'يُقدم التطبيق "كما هو" دون ضمانات من أي نوع. نحن لا نتحمل أي مسؤولية عن أي أضرار قد تنتج عن استخدام التطبيق.',
                      ),

                      _buildSection(
                        'التعديلات على الشروط',
                        'نحتفظ بالحق في تعديل هذه الشروط في أي وقت. سيتم إشعارك بأي تغييرات جوهرية من خلال التطبيق.',
                      ),

                      _buildSection(
                        'التواصل معنا',
                        'إذا كان لديك أي أسئلة حول هذه الشروط، يرجى التواصل معنا عبر\n'
                            '  البريد الإلكتروني : swiftapp075@gmail.com\n '
                            'الهاتف : 0947958283',
                      ),

                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'آخر تحديث: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                          style: AppTextStyles.w400_12.copyWith(
                            color: AppColors.primaryColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Footer
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        foregroundColor: Colors.black87,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text('إغلاق', style: AppTextStyles.w600_16),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        // يمكن إضافة منطق إضافي هنا مثل وضع علامة على الموافقة
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'موافق',
                        style: AppTextStyles.w600_16.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: AppTextStyles.w600_16.copyWith(
              color: AppColors.primaryColor,
            ),

            textAlign: TextAlign.right,
          ),
          SizedBox(height: 8),
          Text(
            content,
            style: AppTextStyles.w400_14.copyWith(
              color: Colors.black87,
              height: 1.5,
            ),
            textAlign: TextAlign.right,
          ),
          SizedBox(height: 8),
          Divider(color: AppColors.primaryColor.withOpacity(0.2), thickness: 1),
        ],
      ),
    );
  }
}
