import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:swift_mobile_app/core/helper_functions/error_snack_bar.dart';
import 'package:swift_mobile_app/core/services/get_it_service.dart';
import 'package:swift_mobile_app/features/seller/auth/domain/repos/seller_auth_repo.dart';
import 'package:swift_mobile_app/features/seller/auth/presentation/cubits/seller_login_cubit/seller_login_cubit.dart';
import 'package:swift_mobile_app/features/seller/auth/presentation/views/widgets/seller_login_view_body.dart';
import 'package:swift_mobile_app/features/seller/home/presentation/views/seller_home_view.dart';

class SellerLoginView extends StatelessWidget {
  const SellerLoginView({super.key});
  static const routName = 'seller-login-view';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => SellerLoginCubit(getIt.get<SellerAuthRepo>()),
          child: BlocConsumer<SellerLoginCubit, SellerLoginState>(
            listener: (context, state) {
              if (state is SellerLoginFailure) {
                errorSnackBar(context, state.errMessage);
              }
              if (state is SellerLoginSuccess) {
                Navigator.pushNamed(context, SellerHomeView.routeName);
              }
            },
            builder: (context, state) {
              return ModalProgressHUD(
                inAsyncCall: state is SellerLoginLoading,
                child: SellerLoginViewBody(),
              );
            },
          ),
        ),
      ),
    );
  }
}
