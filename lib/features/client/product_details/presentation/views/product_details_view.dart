import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift_mobile_app/core/services/get_it_service.dart';
import 'package:swift_mobile_app/features/client/product_details/domain/repo/product_details_repo.dart';
import 'package:swift_mobile_app/features/client/product_details/presentation/cubits/product_attribute_valuecubit/product_attribute_value_cubit.dart';
import 'package:swift_mobile_app/features/client/product_details/presentation/widgets/product_info_view_body.dart';

class ClientProductInfoView extends StatelessWidget {
  const ClientProductInfoView({super.key});
  static const routName = "info page";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create:
              (context) =>
                  ProductAttributesCubit(getIt.get<ProductDetailsRepo>()),
          child: ProductInfoViewBody(),
        ),
      ),
    );
  }
}
