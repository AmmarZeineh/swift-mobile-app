import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift_mobile_app/core/cubits/user_cubit.dart';
import 'package:swift_mobile_app/core/widgets/custom_elevated_button.dart';
import 'package:swift_mobile_app/features/seller/home/presentation/cubits/fetch_products_cubit/fetch_products_cubit.dart';

void showEditDialog(
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
          child: AlertDialog(
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
                onPressed: () {
                  onSave(nameController.text);
                  context.read<FetchProductsCubit>().fetchProducts(
                    context.read<UserCubit>().currentUser!.sellerId,
                  );
                  Navigator.pop(context, true);
                  Navigator.pop(context, true);
                  Navigator.pop(context, true);
                },
                padding: EdgeInsets.all(8),
              ),
            ],
          ),
        ),
  );
}
