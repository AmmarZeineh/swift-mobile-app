import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:swift_mobile_app/core/errors/failure.dart';
import 'package:swift_mobile_app/core/repos/image_repo/image_repo.dart';
import 'package:swift_mobile_app/core/services/backend_endpoints.dart';
import 'package:swift_mobile_app/core/services/database_service.dart';
import 'package:swift_mobile_app/features/seller/add_product/data/models/category_model.dart';
import 'package:swift_mobile_app/features/seller/add_product/domain/entities/category_entity.dart';
import 'package:swift_mobile_app/features/seller/add_product/domain/repos/add_product_repo.dart';
import 'package:swift_mobile_app/features/seller/home/data/models/product_model.dart';
import 'package:swift_mobile_app/features/seller/home/domain/entities/product_entity.dart';

class AddProductRepoImpl implements AddProductRepo {
  final DataBaseService _dataBaseService;
  final ImageRepo _imageRepo;

  AddProductRepoImpl(this._dataBaseService, this._imageRepo);
  @override
  Future<Either<Failure, List<CategoryEntity>>> fetchCategories() async {
    try {
      List<CategoryEntity> categories = [];
      var data = await _dataBaseService.getData(
        path: BackendEndpoints.categories,
      );
      for (var i = 0; i < data.length; i++) {
        categories.add(CategoryModel.fromJson(data[i]).toEntity());
      }
      return Right(categories);
    } catch (e) {
      log(e.toString());
      return Left(ServerFailure('فشل في تحميل الفئات'));
    }
  }

  @override
  Future<Either<Failure, void>> addProduct(
    List<File> images,
    ProductEntity productEntity,
    int sellerId,
  ) async {
    try {
      List<String> urls = [];
      var result = await _imageRepo.uploadMultipleImages(
        images,
        sellerId.toString(),
      );
      result.fold(
        (l) {
          return Left(ServerFailure('فشل في رفع الصور'));
        },
        (r) {
          for (var i = 0; i < r.length; i++) {
            urls.add(r[0]);
          }
        },
      );
      await _dataBaseService.addData(
        data: ProductModel.fromEntity(
          productEntity.copyWith(
            name: productEntity.name,
            description: productEntity.description,
            price: productEntity.price,
            stock: productEntity.stock,
            images: urls,
          ),
        ).toJson(sellerId),
        path: BackendEndpoints.products,
      );
      return Right(null);
    } catch (e) {
      log(e.toString());
      return Left(ServerFailure('فشل في رفع المنتج'));
    }
  }
}
