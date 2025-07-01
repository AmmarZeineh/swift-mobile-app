import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:swift_mobile_app/core/errors/failure.dart';

abstract class ImageRepo {
  Future<Either<Failure, String>> uploadImage(File image, String path);
  Future<Either<Failure, List<String>>> uploadMultipleImages(
    List<File> images,
    String path,
    
  );
}
