import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift_mobile_app/core/services/get_it_service.dart';
import 'package:swift_mobile_app/features/seller/home/domain/entities/product_entity.dart';
import 'package:swift_mobile_app/features/seller/home/domain/repos/seller_home_repo.dart';
import 'package:swift_mobile_app/features/seller/home/presentation/cubits/product_attributes_cubit/product_attributes_cubit.dart';

void deleteAttributeValue(
  BuildContext context,
  int valueId,
  int attributeId,
  ProductEntity productEntity,
) async {
  await getIt.get<SellerHomeRepo>().deleteAttributeValue(
    productEntity.id.toString(),
    attributeId,
    valueId,
  );

  if (context.mounted) {
    context.read<ProductAttributesCubit>().fetchAttributesWithValues(
      productEntity.categoryId,
      productEntity.id,
    );
  }
}
