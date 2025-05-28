import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:swift_mobile_app/core/errors/failure.dart';
import 'package:swift_mobile_app/core/repos/image_repo/image_repo.dart';
import 'package:swift_mobile_app/core/services/backend_endpoints.dart';
import 'package:swift_mobile_app/core/services/database_service.dart';
import 'package:swift_mobile_app/core/services/supabase_auth_service.dart';
import 'package:swift_mobile_app/features/seller/auth/data/models/seller_model.dart';
import 'package:swift_mobile_app/features/seller/auth/domain/entity/seller_entity.dart';
import 'package:swift_mobile_app/features/seller/auth/domain/repos/seller_auth_repo.dart';

class SellerAuthRepoImpl implements SellerAuthRepo {
  final SupabaseAuthService _supabaseAuthService;
  final DataBaseService _dataBaseService;
  final ImageRepo imageRepo;
  SellerAuthRepoImpl(
    this._supabaseAuthService,
    this._dataBaseService,
    this.imageRepo,
  );
  @override
  Future<Either<Failure, SellerEntity>> signupSeller(
    String userName,
    String email,
    String password,
    String phoneNumber,
    String storeName,
    String storeAddress,
    File image,
  ) async {
    try {
      var user = await _supabaseAuthService.createUserWithEmailAndPassword(
        email: email,
        password: password,
        role: 'seller',
      );

      SellerModel sellerModel = SellerModel(
        id: user.id,
        image: '',
        userName: userName,
        email: email,
        phoneNumber: phoneNumber,
        storeName: storeName,
        storeAddress: storeAddress,
      );
      var imageResult = await imageRepo.uploadImage(image, user.id);
      SellerEntity sellerEntity = SellerEntity(
        id: user.id,
        image: '',
        userName: userName,
        email: email,
        phoneNumber: phoneNumber,
        storeName: storeName,
        storeAddress: storeAddress,
      );
      imageResult.fold((e) => throw e, (imageUrl) {
        sellerEntity.image = imageUrl;

        sellerModel.image = imageUrl;
      });
      await _dataBaseService.addData(
        path: BackendEndpoints.pendingSellers,
        data: sellerModel.toJson(),
      );
      return Right(sellerEntity);
    } catch (e) {
      log(e.toString());
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateSellerProfilePic({
    required String userId,
    required String profilePicUrl,
  }) async {
    try {
      log(userId);
      await _dataBaseService.updateData(
        path: BackendEndpoints.pendingSellers,
        id: userId,
        data: {'imageUrl': profilePicUrl},
      );
      return right(null);
    } catch (e) {
      log(e.toString());
      return left(ServerFailure(e.toString()));
    }
  }
}
