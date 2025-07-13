import 'package:flutter/material.dart';
import 'package:swift_mobile_app/core/widgets/custom_elevated_button.dart';

void showEditProfileInfo(
  BuildContext context,
  String title,
  String currentName,
  void Function(String) onSave,
  TextInputType textInputType,
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
                onPressed: () async {
                  onSave(nameController.text);
                },
              ),
            ],
          ),
        ),
  );
}
