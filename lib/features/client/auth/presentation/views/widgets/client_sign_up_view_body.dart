import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swift_mobile_app/core/utils/app_colors.dart';
import 'package:swift_mobile_app/core/utils/app_font_styles.dart';
import 'package:swift_mobile_app/core/widgets/custom_elevated_button.dart';
import 'package:swift_mobile_app/core/widgets/terms_conditions_dialog.dart';
import 'package:swift_mobile_app/features/client/auth/presentation/cubits/client_signup_cubit/client_signup_cubit.dart';
import 'package:swift_mobile_app/features/client/auth/presentation/views/client_login_view.dart';
import 'package:swift_mobile_app/features/client/auth/presentation/views/widgets/custom_header.dart';
import 'package:swift_mobile_app/features/client/auth/presentation/views/widgets/custom_text_field.dart';

class ClientSignupViewBody extends StatefulWidget {
  const ClientSignupViewBody({super.key});

  @override
  State<ClientSignupViewBody> createState() => _ClientSignupViewBodyState();
}

class _ClientSignupViewBodyState extends State<ClientSignupViewBody> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  File? image;
  String? name, email, password, phoneNumber, storeName, storeAddress;
  String? gender;
  int? age;
  bool isObscure = true;
  bool acceptedTerms = false; // متغير لحفظ حالة الموافقة على الشروط

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        autovalidateMode: autovalidateMode,
        child: Column(
          children: [
            SizedBox(
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
                      SizedBox(height: 20),
                      CustomFormTextField(
                        onSaved: (p0) {
                          name = p0;
                        },
                        title: 'الاسم',
                        textInputType: TextInputType.text,
                      ),
                      SizedBox(height: 30),
                      CustomFormTextField(
                        onSaved: (p0) {
                          email = p0;
                        },
                        title: 'البريد الالكتروني',
                        textInputType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 30),
                      CustomFormTextField(
                        onSaved: (p0) {
                          phoneNumber = p0;
                        },
                        title: 'رقم الهاتف',
                        textInputType: TextInputType.number,
                      ),
                      SizedBox(height: 30),
                      // حقل الجنس
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'الجنس',
                            style: AppTextStyles.w400_16.copyWith(
                              color: AppColors.primaryColor,
                            ),
                          ),
                          SizedBox(height: 8),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.primaryColor.withOpacity(0.3),
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: gender,
                                hint: Text(
                                  'اختر الجنس',
                                  style: AppTextStyles.w400_14.copyWith(
                                    color: Colors.grey,
                                  ),
                                ),
                                isExpanded: true,
                                alignment: Alignment.centerRight,
                                items: [
                                  DropdownMenuItem(
                                    value: 'ذكر',
                                    child: Text(
                                      'ذكر',
                                      style: AppTextStyles.w400_14,
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: 'أنثى',
                                    child: Text(
                                      'أنثى',
                                      style: AppTextStyles.w400_14,
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                ],
                                onChanged: (String? value) {
                                  setState(() {
                                    gender = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      // حقل العمر
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'العمر',
                            style: AppTextStyles.w400_16.copyWith(
                              color: AppColors.primaryColor,
                            ),
                          ),
                          SizedBox(height: 8),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.primaryColor.withOpacity(0.3),
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<int>(
                                value: age,
                                hint: Text(
                                  'اختر العمر',
                                  style: AppTextStyles.w400_14.copyWith(
                                    color: Colors.grey,
                                  ),
                                ),
                                isExpanded: true,
                                alignment: Alignment.centerRight,
                                items: List.generate(
                                  68, // من 13 إلى 80
                                  (index) => DropdownMenuItem(
                                    value: index + 13,
                                    child: Text(
                                      '${index + 13} سنة',
                                      style: AppTextStyles.w400_14,
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                ),
                                onChanged: (int? value) {
                                  setState(() {
                                    age = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      CustomFormTextField(
                        onSaved: (p0) {
                          password = p0;
                        },
                        prefixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              isObscure = !isObscure;
                            });
                          },
                          child:
                              isObscure
                                  ? Icon(Icons.visibility)
                                  : Icon(Icons.visibility_off),
                        ),
                        obscureText: isObscure,
                        title: 'كلمة المرور',
                        textInputType: TextInputType.text,
                      ),
                      SizedBox(height: 20),

                      // قسم الشروط والأحكام
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color:
                                acceptedTerms
                                    ? AppColors.primaryColor.withOpacity(0.3)
                                    : Colors.red.withOpacity(0.3),
                            width: acceptedTerms ? 1 : 1.5,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      _showTermsAndConditionsDialog(context);
                                    },
                                    child: RichText(
                                      textAlign: TextAlign.right,
                                      text: TextSpan(
                                        style: AppTextStyles.w400_14.copyWith(
                                          color: AppColors.primaryColor,
                                        ),
                                        children: [
                                          TextSpan(text: 'أوافق على '),
                                          TextSpan(
                                            text: 'الشروط والأحكام',
                                            style: AppTextStyles.w600_14
                                                .copyWith(
                                                  color:
                                                      AppColors.secondaryColor,
                                                  decoration:
                                                      TextDecoration.underline,
                                                ),
                                          ),
                                          TextSpan(text: ' و'),
                                          TextSpan(
                                            text: 'سياسة الخصوصية',
                                            style: AppTextStyles.w600_14
                                                .copyWith(
                                                  color:
                                                      AppColors.secondaryColor,
                                                  decoration:
                                                      TextDecoration.underline,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Transform.scale(
                                  scale: 1.2,
                                  child: Checkbox(
                                    value: acceptedTerms,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        acceptedTerms = value ?? false;
                                      });
                                    },
                                    activeColor: AppColors.primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            if (!acceptedTerms)
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  'يجب الموافقة على الشروط والأحكام للمتابعة',
                                  style: AppTextStyles.w400_12.copyWith(
                                    color: Colors.red,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                          ],
                        ),
                      ),

                      SizedBox(height: 16),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            ClientLoginView.routeName,
                          );
                        },
                        child: Text(
                          'لديك حساب بالفعل؟',
                          style: AppTextStyles.w400_16.copyWith(
                            color: AppColors.secondaryColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: CustomElevatedButton(
                title: 'تسجيل',
                onPressed: () {
                  if (formKey.currentState!.validate() &&
                      gender != null &&
                      age != null &&
                      acceptedTerms) {
                    formKey.currentState!.save();

                    context.read<ClientSignupCubit>().signupClient(
                      email!,
                      password!,
                      name!,
                      phoneNumber!,
                      gender!,
                      age!,
                    );
                  } else {
                    setState(() {
                      autovalidateMode = AutovalidateMode.onUserInteraction;
                    });

                    String errorMessage = '';
                    if (gender == null || age == null) {
                      errorMessage = 'يرجى اختيار الجنس والعمر';
                    } else if (!acceptedTerms) {
                      errorMessage = 'يجب الموافقة على الشروط والأحكام';
                    }

                    if (errorMessage.isNotEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(errorMessage),
                          backgroundColor: Colors.red,
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.all(16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      );
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showTermsAndConditionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return TermsConditionsDialog();
      },
    );
  }
}
