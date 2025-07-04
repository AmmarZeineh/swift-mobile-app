import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift_mobile_app/core/cubits/user_cubit.dart';
import 'package:swift_mobile_app/core/helper_functions/show_edit_dialog.dart';
import 'package:swift_mobile_app/features/seller/home/domain/entities/product_entity.dart';
import 'package:swift_mobile_app/features/seller/home/presentation/cubits/edit_product_details_cubit/cubit/edit_product_details_cubit_cubit.dart';
import 'package:swift_mobile_app/features/seller/home/presentation/cubits/fetch_products_cubit/fetch_products_cubit.dart';
import 'package:swift_mobile_app/features/seller/home/presentation/cubits/product_attributes_cubit/product_attributes_cubit.dart';

void showEditSingleValueDialog(
  BuildContext context,
  String attributeName,
  String currentValue,
  int valueId,
  int attributeId,
  ProductEntity productEntity,
) {
  showEditDialog(productEntity, context, attributeName, currentValue, (
    newValue,
  ) async {
    await context.read<EditProductDetailsCubitCubit>().editProductAttribute(
      productEntity,
      attributeId.toString(),
      valueId.toString(),
      newValue,
    );
    if (context.mounted) {
      context.read<ProductAttributesCubit>().fetchAttributesWithValues(
        productEntity.categoryId,
        productEntity.id,
      );
      context.read<FetchProductsCubit>().fetchProducts(
        context.read<UserCubit>().currentUser!.sellerId,
      );
      Navigator.pop(context, true);
      Navigator.pop(context, true);
    }
  });
}
