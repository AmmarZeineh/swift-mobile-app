import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:swift_mobile_app/core/helper_functions/snack_bars.dart';
import 'package:swift_mobile_app/features/seller/home/domain/entities/product_entity.dart';
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
        child: BlocConsumer<ProductAttributesCubit, ProductAttributesState>(
          listener: (context, state) {
            // استخدم listener للـ error handling فقط
            if (state is ProductAttributesFailure) {
              showErrorMessage(state.errMessage, context);
            }
          },
          builder: (context, state) {
            return ModalProgressHUD(
              inAsyncCall: state is ProductAttributesLoading,
              child: SellerProductDetailsViewBody(productEntity: productEntity),
            );
          },
        ),
      ),
    );
  }
}
