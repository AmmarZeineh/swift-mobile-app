import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
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
      String url = await storageService.uploadFile(
        image,
        '${BackendEndpoints.images}.$path',
        BackendEndpoints.images,
      );
      return Right(url);
    } catch (e) {
      log(e.toString());
      return Left(ServerFailure('Failed to uoload image'));
    }
  }

  @override
  Future<Either<Failure, List<String>>> uploadMultipleImages(
    List<File> images,
    String path,
  ) async {
    try {
      List<String> urls = [];
      for (var i = 0; i < images.length; i++) {
        String url = await storageService.uploadFile(
          images[i],
          '${BackendEndpoints.productImages}.$path',
          BackendEndpoints.productImages,
        );
        urls.add(url);
      }
      log(urls[0]);
      return Right(urls);
    } catch (e) {
      return Left(ServerFailure('Failed to uoload image'));
    }
  }
}
