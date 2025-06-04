
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift_mobile_app/core/utils/app_colors.dart';
import 'package:swift_mobile_app/core/utils/app_font_styles.dart';
import 'package:swift_mobile_app/core/widgets/custom_elevated_button.dart';
import 'package:swift_mobile_app/core/widgets/custom_text_form_field.dart';
import 'package:swift_mobile_app/features/seller/auth/presentation/cubits/seller_login_cubit/seller_login_cubit.dart';
import 'package:swift_mobile_app/features/seller/auth/presentation/views/seller_signup_view.dart';
import 'package:swift_mobile_app/features/seller/auth/presentation/views/widgets/custom_header.dart';

class SellerLoginViewBody extends StatefulWidget {
  const SellerLoginViewBody({super.key});

  @override
  State<SellerLoginViewBody> createState() => _SellerLoginViewBodyState();
}

class _SellerLoginViewBodyState extends State<SellerLoginViewBody> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  String? email, password;
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Form(
          key: formKey,
          autovalidateMode: autovalidateMode,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: 30),
              CustomHeader(),
              SizedBox(height: 30),
              Text(
                'اهلا',
                style: AppTextStyles.w400_30.copyWith(color: Colors.grey),
              ),
              SizedBox(height: 4),
              Text('مرحبا بعودتك', style: AppTextStyles.w400_30),
              SizedBox(height: 60),
              CustomFormTextField(
                onSaved: (p0) {
                  email = p0;
                },
                title: 'الايميل',
                textInputType: TextInputType.emailAddress,
              ),
              SizedBox(height: 24),
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
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, SellerSignupView.routeName);
                    },
                    child: Text(
                      'ليس لديك حساب؟',
                      style: AppTextStyles.w600_18.copyWith(
                        color: AppColors.secondaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),
              CustomElevatedButton(
                title: 'تسجيل دخول',
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    context.read<SellerLoginCubit>().loginSeller(
                      email!,
                      password!,
                    );
                  } else {
                    setState(() {});
                    autovalidateMode = AutovalidateMode.onUserInteraction;
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
