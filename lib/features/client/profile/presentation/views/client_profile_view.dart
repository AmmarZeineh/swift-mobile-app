import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift_mobile_app/core/cubits/user_cubit/user_cubit.dart';
import 'package:swift_mobile_app/core/repos/profile_repo/profile_repo.dart';
import 'package:swift_mobile_app/core/services/get_it_service.dart';
import 'package:swift_mobile_app/features/client/profile/presentation/views/widgets/client_profile_view_body.dart';

import '../../../../../core/cubits/edit_profile_details_cubit/edit_profile_details_cubit.dart';

class ClientProfileView extends StatelessWidget {
  const ClientProfileView({super.key});
  static const routeName = 'Cllient-Profile-View';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create:
              (context) => EditProfileDetailsCubit(getIt.get<ProfileRepo>()),
          child: ClientProfileViewBody(
            clientEntity: context.read<UserCubit>().currentUser!,
          ),
        ),
      ),
    );
  }
}
