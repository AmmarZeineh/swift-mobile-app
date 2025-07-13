import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:swift_mobile_app/core/helper_functions/snack_bars.dart';
import 'package:swift_mobile_app/core/services/get_it_service.dart';
import 'package:swift_mobile_app/features/client/auth/domain/repos/client_auth_repo.dart';
import 'package:swift_mobile_app/features/client/auth/presentation/cubits/client_login_cubit/client_login_cubit.dart';
import 'package:swift_mobile_app/features/client/auth/presentation/views/widgets/client_login_view_body.dart';
import 'package:swift_mobile_app/features/client/home/presentation/views/client_home_view.dart';

class ClientLoginView extends StatelessWidget {
  const ClientLoginView({super.key});
  static const routeName = 'client-login-view';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => ClientLoginCubit(getIt.get<ClientAuthRepo>()),
          child: BlocConsumer<ClientLoginCubit, ClientLoginState>(
            listener: (context, state) {
              if (state is ClientLoginFailure) {
                showErrorMessage(state.errMessage, context);
              }
              if (state is ClientLoginSuccess) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  ClientHomeView.routeName,
                  arguments: state.clientEntity,
                  (route) => false,
                );
              }
            },
            builder: (context, state) {
              return ModalProgressHUD(
                inAsyncCall: state is ClientLoginLoading,
                child: ClientLoginViewBody(),
              );
            },
          ),
        ),
      ),
    );
  }
}
