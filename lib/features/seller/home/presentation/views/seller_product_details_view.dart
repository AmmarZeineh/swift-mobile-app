import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:swift_mobile_app/core/helper_functions/error_snack_bar.dart';
import 'package:swift_mobile_app/core/services/get_it_service.dart';
import 'package:swift_mobile_app/features/seller/home/domain/entities/product_entity.dart';
import 'package:swift_mobile_app/features/seller/home/domain/repos/seller_home_repo.dart';
import 'package:swift_mobile_app/features/seller/home/presentation/cubits/product_attributes_cubit/product_attributes_cubit.dart';
import 'package:swift_mobile_app/features/seller/home/presentation/views/widgets/seller_product_details_view_body.dart';

class SellerProductDetailsView extends StatelessWidget {
  const SellerProductDetailsView({super.key, required this.productEntity});
  static const routeName = 'SellerProductDetailsView';
  final ProductEntity productEntity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create:
              (context) => ProductAttributesCubit(getIt.get<SellerHomeRepo>()),
          child: BlocConsumer<ProductAttributesCubit, ProductAttributesState>(
            listener: (context, state) {
              // استخدم listener للـ error handling فقط
              if (state is ProductAttributesFailure) {
                errorSnackBar(context, state.errMessage);
              }
            },
            builder: (context, state) {
              return ModalProgressHUD(
                inAsyncCall: state is ProductAttributesLoading,
                child: SellerProductDetailsViewBody(
                  productEntity: productEntity,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
