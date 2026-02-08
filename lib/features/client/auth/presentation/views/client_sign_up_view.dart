import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:swift_mobile_app/core/helper_functions/snack_bars.dart';
import 'package:swift_mobile_app/core/services/get_it_service.dart';
import 'package:swift_mobile_app/core/utils/app_colors.dart';
import 'package:swift_mobile_app/features/client/auth/domain/repos/client_auth_repo.dart';
import 'package:swift_mobile_app/features/client/auth/presentation/cubits/client_signup_cubit/client_signup_cubit.dart';
import 'package:swift_mobile_app/features/client/auth/presentation/views/client_login_view.dart';
import 'package:swift_mobile_app/features/client/auth/presentation/views/widgets/client_sign_up_view_body.dart';

class ClientSignupView extends StatelessWidget {
  const ClientSignupView({super.key});
  static const routeName = 'client-signup-view';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => ClientSignupCubit(getIt.get<ClientAuthRepo>()),
          child: BlocConsumer<ClientSignupCubit, ClientSignupState>(
            listener: (context, state) {
              if (state is ClientSignupFailure) {
                showErrorMessage(state.errMessage, context);
              }
              if (state is ClientSignupSuccess) {
                showSuccessMessage('تم تسجيل حسابك بنجاح', context);
                Navigator.pushNamed(context, ClientLoginView.routeName);
              }
            },
            builder: (context, state) {
              return ModalProgressHUD(
                progressIndicator: const CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ),
                inAsyncCall: state is ClientSignupLoading,
                child: ClientSignupViewBody(),
              );
            },
          ),
        ),
      ),
    );
  }
}
