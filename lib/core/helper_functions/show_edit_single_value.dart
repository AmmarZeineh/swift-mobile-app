import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift_mobile_app/core/helper_functions/show_dialog.dart';
import 'package:swift_mobile_app/core/services/get_it_service.dart';
import 'package:swift_mobile_app/features/seller/home/domain/entities/product_entity.dart';
import 'package:swift_mobile_app/features/seller/home/domain/repos/seller_home_repo.dart';
import 'package:swift_mobile_app/features/seller/home/presentation/cubits/product_attributes_cubit/product_attributes_cubit.dart';

void showEditSingleValueDialog(
  BuildContext context,
  String attributeName,
  String currentValue,
  int valueId,
  int attributeId,
  ProductEntity productEntity,
) {
  showEditDialog(context, attributeName, currentValue, (newValue) async {
    await getIt.get<SellerHomeRepo>().editAttributeValue(
      productEntity.id.toString(),
      attributeId,
      valueId,
      newValue,
    );

    if (context.mounted) {
      Navigator.pop(context, true);
      context.read<ProductAttributesCubit>().fetchAttributesWithValues(
        productEntity.categoryId,
        productEntity.id,
      );
    }
  });
}
