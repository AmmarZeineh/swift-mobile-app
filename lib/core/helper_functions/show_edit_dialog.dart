import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift_mobile_app/core/cubits/user_cubit/user_cubit.dart';
import 'package:swift_mobile_app/core/entities/product_entity.dart';
import 'package:swift_mobile_app/core/utils/app_colors.dart';
import 'package:swift_mobile_app/core/widgets/custom_elevated_button.dart';
import 'package:swift_mobile_app/features/seller/home/presentation/cubits/edit_product_details_cubit/cubit/edit_product_details_cubit_cubit.dart';
import 'package:swift_mobile_app/features/seller/home/presentation/cubits/fetch_products_cubit/seller_fetch_products_cubit.dart';

void showEditDialog(
  ProductEntity productEntity,
  BuildContext context,
  String title,
  String currentName,
  void Function(String) onSave,
) {
  final TextEditingController nameController = TextEditingController(
    text: currentName,
  );

  showDialog(
    context: context,
    builder:
        (context) => Directionality(
          textDirection: TextDirection.rtl, // <<< المهم
          child: BlocBuilder<
            EditProductDetailsCubitCubit,
            EditProductDetailsCubitState
          >(
            builder: (context, state) {
              if (state is EditProductDetailsCubitLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                );
              }
              return AlertDialog(
                title: Text(title),
                content: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: "$title الجديد"),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("إلغاء"),
                  ),
                  CustomElevatedButton(
                    title: 'حفظ',
                    onPressed: () async {
                      onSave(nameController.text);
                      context.read<SellerFetchProductsCubit>().fetchProducts(
                        context.read<UserCubit>().currentUser!.sellerId,
                      );
                    },
                    padding: EdgeInsets.all(8),
                  ),
                ],
              );
            },
          ),
        ),
  );
}
