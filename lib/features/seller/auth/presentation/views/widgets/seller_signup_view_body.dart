import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swift_mobile_app/core/helper_functions/snack_bars.dart';
import 'package:swift_mobile_app/core/utils/app_colors.dart';
import 'package:swift_mobile_app/core/utils/app_font_styles.dart';
import 'package:swift_mobile_app/core/widgets/custom_elevated_button.dart';
import 'package:swift_mobile_app/core/widgets/custom_text_form_field.dart';
import 'package:swift_mobile_app/features/seller/auth/presentation/cubits/seller_signup_cubit/seller_signup_cubit.dart';
import 'package:swift_mobile_app/features/seller/auth/presentation/views/seller_login_view.dart';
import 'package:swift_mobile_app/features/seller/auth/presentation/views/widgets/custom_header.dart';
import 'package:swift_mobile_app/features/seller/auth/presentation/views/widgets/image_picker_container.dart';

class SellerSignupViewBody extends StatefulWidget {
  const SellerSignupViewBody({super.key});

  @override
  State<SellerSignupViewBody> createState() => _SellerSignupViewBodyState();
}

class _SellerSignupViewBodyState extends State<SellerSignupViewBody> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  File? image;
  String? name, email, password, phoneNumber, storeName, storeAddress;
  bool isObscure = true;
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
                      Center(
                        child: ImagePickerContainer(
                          onChanged: (image) {
                            this.image = image;
                          },
                        ),
                      ),
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
                      SizedBox(height: 30),
                      // CustomFormTextField(
                      //   onChanged: (p0) {
                      //     if (p0 != password) {
                      //       autovalidateMode = AutovalidateMode.always;
                      //     }
                      //   },
                      //   prefixIcon: Icon(Icons.visibility),
                      //   obscureText: true,
                      //   title: 'تأكيد كلمة المرور',
                      //   textInputType: TextInputType.text,
                      // ),
                      // SizedBox(height: 30),
                      CustomFormTextField(
                        onSaved: (p0) {
                          storeName = p0;
                        },
                        title: 'اسم متجرك',
                        textInputType: TextInputType.text,
                      ),
                      SizedBox(height: 30),
                      CustomFormTextField(
                        onSaved: (p0) {
                          storeAddress = p0;
                        },
                        title: 'عنوان متجرك بالتفصيل',
                        textInputType: TextInputType.text,
                      ),
                      SizedBox(height: 16),

                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            SellerLoginView.routName,
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
              child: SizedBox(
                width: double.infinity,
                child: CustomElevatedButton(
                  padding: EdgeInsets.symmetric(horizontal: 29, vertical: 15),
                  title: 'تسجيل',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      if (image == null) {
                        showErrorMessage('يرجى اختيار صورة هوية', context);
                      } else {
                        context.read<SellerSignupCubit>().signupSeller(
                          email!,
                          password!,
                          name!,
                          phoneNumber!,
                          storeName!,
                          storeAddress!,
                          image!,
                        );
                      }
                    } else {
                      setState(() {});
                      autovalidateMode = AutovalidateMode.onUserInteraction;
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
