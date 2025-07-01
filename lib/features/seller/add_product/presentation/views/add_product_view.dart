import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift_mobile_app/core/services/get_it_service.dart';
import 'package:swift_mobile_app/features/seller/add_product/domain/repos/add_product_repo.dart';
import 'package:swift_mobile_app/features/seller/add_product/presentation/cubits/add_product_cubit/add_product_cubit.dart';
import 'package:swift_mobile_app/features/seller/add_product/presentation/cubits/fetch_categories_cubit/fetch_categories_cubit.dart';
import 'package:swift_mobile_app/features/seller/add_product/presentation/views/widgets/add_product_view_body.dart';

class AddProductView extends StatelessWidget {
  const AddProductView({super.key});
  static const routeName = 'add-product';
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create:
                    (context) =>
                        FetchCategoriesCubit(getIt.get<AddProductRepo>()),
              ),
              BlocProvider(
                create:
                    (context) => AddProductCubit(getIt.get<AddProductRepo>()),
              ),
            ],
            child: AddProductViewBody(),
          ),
        ),
      ),
    );
  }
}
