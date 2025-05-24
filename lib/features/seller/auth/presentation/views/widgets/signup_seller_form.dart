import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swift_mobile_app/core/utils/app_colors.dart';
import 'package:swift_mobile_app/core/utils/app_font_styles.dart';
import 'package:swift_mobile_app/core/widgets/custom_text_form_field.dart';
import 'package:swift_mobile_app/features/seller/auth/presentation/views/widgets/custom_header.dart';
import 'package:swift_mobile_app/features/seller/auth/presentation/views/widgets/image_picker_container.dart';

class SignupSellerForm extends StatelessWidget {
  const SignupSellerForm({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 700.h,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: 30.h),
              CustomHeader(),
              SizedBox(height: 20),
              Text(
                'مرحبا',
                style: AppTextStyles.w700_30.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
              Center(child: ImagePickerContainer(onChanged: (image) {})),
              CustomFormTextField(
                title: 'الاسم',
                textInputType: TextInputType.text,
              ),
              SizedBox(height: 30),
              CustomFormTextField(
                title: 'البريد الالكتروني',
                textInputType: TextInputType.emailAddress,
              ),
              SizedBox(height: 30),
              CustomFormTextField(
                title: 'رقم الهاتف',
                textInputType: TextInputType.number,
              ),
              SizedBox(height: 30),
              CustomFormTextField(
                prefixIcon: Icon(Icons.visibility),
                obscureText: true,
                title: 'كلمة المرور',
                textInputType: TextInputType.text,
              ),
              SizedBox(height: 30),
              CustomFormTextField(
                prefixIcon: Icon(Icons.visibility),
                obscureText: true,
                title: 'تأكيد كلمة المرور',
                textInputType: TextInputType.text,
              ),
              SizedBox(height: 30),
              CustomFormTextField(
                title: 'اسم متجرك',
                textInputType: TextInputType.text,
              ),
              SizedBox(height: 30),
              CustomFormTextField(
                title: 'عنوان متجرك بالتفصيل',
                textInputType: TextInputType.text,
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
