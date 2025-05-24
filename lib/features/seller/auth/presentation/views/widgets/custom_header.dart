import 'package:flutter/material.dart';
import 'package:swift_mobile_app/core/utils/app_images.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(thickness: 1, color: Colors.grey, height: 1)),
        SizedBox(width: 18),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset(Assets.imagesSwiftLogoIcon23),
          ),
        ),
        SizedBox(width: 18),

        Expanded(child: Divider(thickness: 1, color: Colors.grey, height: 1)),
      ],
    );
  }
}
