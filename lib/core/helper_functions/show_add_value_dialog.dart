import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift_mobile_app/core/helper_functions/show_edit_dialog.dart';
import 'package:swift_mobile_app/features/seller/home/domain/entities/product_entity.dart';
import 'package:swift_mobile_app/features/seller/home/presentation/cubits/edit_product_details_cubit/cubit/edit_product_details_cubit_cubit.dart';
import 'package:swift_mobile_app/features/seller/home/presentation/cubits/product_attributes_cubit/product_attributes_cubit.dart';

void showAddValueDialog(
  BuildContext context,
  String attributeName,
  int attributeId,
  ProductEntity productEntity,
) {
  showEditDialog(
    productEntity,
    context,
    'إضافة قيمة جديدة لـ $attributeName',
    '',
    (newValue) async {
      context.read<EditProductDetailsCubitCubit>().addAttributeValue(
        productEntity,
        attributeId.toString(),
        newValue.toString(),
      );
      context.read<ProductAttributesCubit>().fetchAttributesWithValues(
        productEntity.categoryId,
        productEntity.id,
      );
      Navigator.pop(context);
      Navigator.pop(context);
    },
  );
}
