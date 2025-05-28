import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:swift_mobile_app/core/helper_functions/error_snack_bar.dart';
import 'package:swift_mobile_app/core/repos/image_repo/image_repo.dart';
import 'package:swift_mobile_app/core/services/get_it_service.dart';
import 'package:swift_mobile_app/features/seller/auth/domain/repos/seller_auth_repo.dart';
import 'package:swift_mobile_app/features/seller/auth/presentation/cubits/signup_cubit/signup_cubit.dart';
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
              (context) => SignupCubit(
                getIt.get<SellerAuthRepo>(),
                getIt.get<ImageRepo>(),
              ),
          child: BlocConsumer<SignupCubit, SignupState>(
            listener: (context, state) {
              if (state is SignupFailure) {
                errorSnackBar(context, state.errMessage);
              }
              if (state is SignupSuccess) {
                errorSnackBar(context, 'Success');
              }
            },
            builder: (context, state) {
              return ModalProgressHUD(
                inAsyncCall: state is SignupLoading,
                child: SellerSignupViewBody(),
              );
            },
          ),
        ),
      ),
    );
  }
}
