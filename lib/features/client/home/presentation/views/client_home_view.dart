import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift_mobile_app/core/services/get_it_service.dart';
import 'package:swift_mobile_app/features/client/home/domain/repos/home_repo.dart';
import 'package:swift_mobile_app/features/client/home/presentation/cubits/fetch_categories_cubit/fetch_categories_cubit.dart';
import 'package:swift_mobile_app/features/client/home/presentation/cubits/fetch_product_cubit/fetch_products_cubit.dart';
import 'package:swift_mobile_app/features/client/home/presentation/views/widgets/client_home_view_body.dart';

class ClientHomeView extends StatelessWidget {
  const ClientHomeView({super.key});
  static const routeName = 'client-home-view';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => FetchCategoriesCubit(getIt.get<HomeRepo>()),
            ),
            BlocProvider(
              create: (context) => FetchProductsCubit(getIt.get<HomeRepo>()),
            ),
          ],
          child: ClientHomeViewBody(),
        ),
      ),
    );
  }
}
