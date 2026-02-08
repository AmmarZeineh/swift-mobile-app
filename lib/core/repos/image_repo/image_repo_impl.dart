import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:swift_mobile_app/core/errors/failure.dart';
import 'package:swift_mobile_app/core/repos/image_repo/image_repo.dart';
import 'package:swift_mobile_app/core/services/backend_endpoints.dart';
import 'package:swift_mobile_app/core/services/storage_service.dart';

class ImageRepoImpl implements ImageRepo {
  final StorageService storageService;

  ImageRepoImpl(this.storageService);

  @override
  Future<Either<Failure, String>> uploadImage(File image, String path) async {
    try {
      // ضغط الصورة قبل الرفع
      File compressedImage = await _compressImage(image);

      String url = await storageService.uploadFile(
        compressedImage,
        '${BackendEndpoints.images}.$path',
        BackendEndpoints.images,
      );

      return Right(url);
    } catch (e) {
      log(e.toString());
      return Left(ServerFailure('Failed to upload image'));
    }
  }

  @override
  Future<Either<Failure, List<String>>> uploadMultipleImages(
    List<File> images,
    String path,
  ) async {
    try {
      List<String> urls = [];

      for (var image in images) {
        // ضغط كل صورة
        File compressedImage = await _compressImage(image);

        String url = await storageService.uploadFile(
          compressedImage,
          '${BackendEndpoints.productImages}.$path',
          BackendEndpoints.productImages,
        );
        urls.add(url);
      }

      log(urls.isNotEmpty ? urls[0] : 'No images uploaded');
      return Right(urls);
    } catch (e) {
      log(e.toString());
      return Left(ServerFailure('Failed to upload images'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteImages(
    List<String> urls,
    String path,
  ) async {
    try {
      for (var url in urls) {
        await storageService.deleteFile(url, BackendEndpoints.productImages);
      }
      return Right(null);
    } catch (e) {
      log(e.toString());
      return Left(ServerFailure('Failed to delete images'));
    }
  }

  /// ضغط الصورة
  Future<File> _compressImage(File image) async {
    try {
      final bytes = await image.readAsBytes();

      final compressedBytes = await FlutterImageCompress.compressWithList(
        bytes,
        quality: 80,
        minWidth: 800,
        minHeight: 800,
      );

      final tempDir = await getTemporaryDirectory();
      final fileName = path.basenameWithoutExtension(image.path);
      final compressedPath = path.join(
        tempDir.path,
        '${fileName}_compressed.jpg',
      );

      final compressedFile = File(compressedPath);
      await compressedFile.writeAsBytes(compressedBytes);

      return compressedFile;
    } catch (e) {
      log('Error compressing image: $e');
      return image;
    }
  }
}
