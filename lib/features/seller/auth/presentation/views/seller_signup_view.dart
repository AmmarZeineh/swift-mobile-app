import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:swift_mobile_app/core/helper_functions/error_snack_bar.dart';
import 'package:swift_mobile_app/core/repos/image_repo/image_repo.dart';
import 'package:swift_mobile_app/core/services/get_it_service.dart';
import 'package:swift_mobile_app/core/utils/app_colors.dart';
import 'package:swift_mobile_app/features/seller/auth/domain/repos/seller_auth_repo.dart';
import 'package:swift_mobile_app/features/seller/auth/presentation/cubits/seller_signup_cubit/seller_signup_cubit.dart';
import 'package:swift_mobile_app/features/seller/auth/presentation/views/widgets/seller_signup_view_body.dart';

class SellerSignupView extends StatelessWidget {
  const SellerSignupView({super.key});
  static const routeName = 'seller-signup-view';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create:
              (context) => SellerSignupCubit(
                getIt.get<SellerAuthRepo>(),
                getIt.get<ImageRepo>(),
              ),
          child: BlocConsumer<SellerSignupCubit, SellerSignupState>(
            listener: (context, state) {
              if (state is SellerSignupFailure) {
                errorSnackBar(context, state.errMessage);
              }
              if (state is SellerSignupSuccess) {
                errorSnackBar(context, 'تم تسجيل حسابك بنجاح');
              }
            },
            builder: (context, state) {
              return ModalProgressHUD(
                progressIndicator: const CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ),
                inAsyncCall: state is SellerSignupLoading,
                child: SellerSignupViewBody(),
              );
            },
          ),
        ),
      ),
    );
  }
}
