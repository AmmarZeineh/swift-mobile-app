import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift_mobile_app/core/cubits/user_cubit/user_cubit.dart';
import 'package:swift_mobile_app/core/services/get_it_service.dart';
import 'package:swift_mobile_app/features/client/profile/domain/repos/client_profile_repo.dart';
import 'package:swift_mobile_app/features/client/profile/presentation/cubits/edit_profile_details_cubit/edit_profile_details_cubit.dart';
import 'package:swift_mobile_app/features/client/profile/presentation/views/widgets/client_profile_view_body.dart';

class ClientProfileView extends StatelessWidget {
  const ClientProfileView({super.key});
  static const routeName = 'Cllient-Profile-View';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => EditProfileDetailsCubit(getIt.get<CLientProfileRepo>()),
          child: ClientProfileViewBody(
            clientEntity: context.read<UserCubit>().currentUser!,
          ),
        ),
      ),
    );
  }
}
