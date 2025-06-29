import 'package:flutter/material.dart';
import 'package:swift_mobile_app/core/helper_functions/show_add_value_dialog.dart';
import 'package:swift_mobile_app/core/helper_functions/show_delete_value_dialog.dart';
import 'package:swift_mobile_app/core/helper_functions/show_edit_single_value.dart';
import 'package:swift_mobile_app/core/utils/app_colors.dart';
import 'package:swift_mobile_app/core/widgets/custom_elevated_button.dart';
import 'package:swift_mobile_app/features/seller/home/domain/entities/product_entity.dart';

void showEditAttributeDialog(
  BuildContext context,
  String attributeName,
  List<dynamic> currentValues,
  int attributeId,
  ProductEntity productEntity,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          title: Text('تعديل $attributeName'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('القيم الحالية'),
                SizedBox(height: 16),
                ...currentValues.map(
                  (value) => Card(
                    child: ListTile(
                      title: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(value.value.toString()),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              showEditSingleValueDialog(
                                context,
                                attributeName,
                                value.value.toString(),
                                value.id,
                                attributeId,
                                productEntity,
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: AppColors.primaryColor,
                            ),
                            onPressed: () {
                              deleteAttributeValue(
                                context,
                                value.id,
                                attributeId,
                                productEntity,
                              );
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    CustomElevatedButton(
                      onPressed: () {
                        showAddValueDialog(
                          context,
                          attributeName,
                          attributeId,
                          productEntity,
                        );
                      },
                      title: 'إضافة قيمة جديدة',
                      padding: EdgeInsets.all(8),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('إغلاق'),
            ),
          ],
        ),
      );
    },
  );
}
