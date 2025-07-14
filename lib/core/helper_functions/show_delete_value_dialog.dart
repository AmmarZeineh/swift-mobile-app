import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift_mobile_app/core/cubits/user_cubit/user_cubit.dart';
import 'package:swift_mobile_app/core/entities/product_entity.dart';
import 'package:swift_mobile_app/features/seller/home/presentation/cubits/edit_product_details_cubit/cubit/edit_product_details_cubit_cubit.dart';
import 'package:swift_mobile_app/features/seller/home/presentation/cubits/fetch_products_cubit/fetch_products_cubit.dart';
import 'package:swift_mobile_app/features/seller/home/presentation/cubits/product_attributes_cubit/product_attributes_cubit.dart';

void deleteAttributeValue(
  BuildContext context,
  int valueId,
  int attributeId,
  ProductEntity productEntity,
) async {
  context.read<EditProductDetailsCubitCubit>().deleteProductAttribute(
    productEntity,
    attributeId.toString(),
    valueId.toString(),
  );
  context.read<ProductAttributesCubit>().fetchAttributesWithValues(
    productEntity.categoryId,
    productEntity.id,
  );

  context.read<FetchProductsCubit>().fetchProducts(
    context.read<UserCubit>().currentUser!.sellerId,
  );
}
