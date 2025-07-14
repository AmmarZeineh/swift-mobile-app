import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift_mobile_app/core/services/get_it_service.dart';
import 'package:swift_mobile_app/features/client/home/domain/repos/home_repo.dart';
import 'package:swift_mobile_app/features/client/home/presentation/cubits/search_product_cubit/search_product_cubit.dart';
import 'package:swift_mobile_app/features/client/home/presentation/views/widgets/search_view_body.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});
  static const String routeName = "search_view";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocProvider(
          create: (context) => SearchProductCubit(getIt.get<HomeRepo>()),
          child: SearchViewBody(),
        ),
      ),
    );
  }
}
