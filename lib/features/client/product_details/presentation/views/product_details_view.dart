import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift_mobile_app/core/services/get_it_service.dart';
import 'package:swift_mobile_app/features/client/home/domain/entities/product_entity.dart';
import 'package:swift_mobile_app/features/client/product_details/domain/repo/product_details_repo.dart';
import 'package:swift_mobile_app/features/client/product_details/presentation/cubits/add_to_cart_cubit/add_to_cart_cubit.dart';
import 'package:swift_mobile_app/features/client/product_details/presentation/cubits/product_attribute_valuecubit/product_attribute_value_cubit.dart';
import 'package:swift_mobile_app/features/client/product_details/presentation/cubits/reviews_cubit/reviews_cubit.dart';
import 'package:swift_mobile_app/features/client/product_details/presentation/views/widgets/product_info_view_body.dart';

class ClientProductInfoView extends StatelessWidget {
  const ClientProductInfoView({super.key, required this.product});
  static const routName = "info page";
  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create:
                  (context) => AddToCartCubit(getIt.get<ProductDetailsRepo>()),
            ),
            BlocProvider(
              create:
                  (context) =>
                      ProductAttributesCubit(getIt.get<ProductDetailsRepo>()),
            ),
            BlocProvider(
              create:
                  (context) => ReviewsCubit(getIt.get<ProductDetailsRepo>()),
            ),
          ],
          child: ProductInfoViewBody(product: product),
        ),
      ),
    );
  }
}
