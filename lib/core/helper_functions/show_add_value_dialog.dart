import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift_mobile_app/core/helper_functions/show_dialog.dart';
import 'package:swift_mobile_app/core/services/get_it_service.dart';
import 'package:swift_mobile_app/features/seller/home/domain/entities/product_entity.dart';
import 'package:swift_mobile_app/features/seller/home/domain/repos/seller_home_repo.dart';
import 'package:swift_mobile_app/features/seller/home/presentation/cubits/product_attributes_cubit/product_attributes_cubit.dart';

void showAddValueDialog(
  BuildContext context,
  String attributeName,
  int attributeId,
  ProductEntity productEntity,
) {
  showEditDialog(context, 'إضافة قيمة جديدة لـ $attributeName', '', (
    newValue,
  ) async {
    await getIt.get<SellerHomeRepo>().addAttributeValue(
      productEntity.id.toString(),
      attributeId,
      newValue,
    );

    if (context.mounted) {
      Navigator.pop(context);
      context.read<ProductAttributesCubit>().fetchAttributesWithValues(
        productEntity.categoryId,
        productEntity.id,
      );
    }
  });
}
