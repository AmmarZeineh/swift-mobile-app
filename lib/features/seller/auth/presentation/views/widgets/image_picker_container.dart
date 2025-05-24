import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swift_mobile_app/core/utils/app_images.dart';

class ImagePickerContainer extends StatefulWidget {
  const ImagePickerContainer({super.key, required this.onChanged});
  final ValueChanged<File?> onChanged;
  @override
  State<ImagePickerContainer> createState() => _ImagePickerContainerState();
}

class _ImagePickerContainerState extends State<ImagePickerContainer> {
  File? imageFile;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final ImagePicker picker = ImagePicker();
        // Pick an image.
        final XFile? image = await picker.pickImage(
          source: ImageSource.gallery,
        );
        if (image != null) {
          imageFile = File(image.path);
          widget.onChanged(imageFile!);

          setState(() {});
        } else {}
      },
      child: ClipOval(
        child: Container(
          height: 150.h,
          width: 150.w,
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child:
              imageFile == null
                  ? FittedBox(child: SvgPicture.asset(Assets.imagesProfileIcon))
                  : Image.file(imageFile!),
        ),
      ),
    );
  }
}
