import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift_mobile_app/constants.dart';
import 'package:swift_mobile_app/core/cubits/user_cubit.dart';
import 'package:swift_mobile_app/core/errors/failure.dart';
import 'package:swift_mobile_app/core/repos/image_repo/image_repo.dart';
import 'package:swift_mobile_app/core/services/backend_endpoints.dart';
import 'package:swift_mobile_app/core/services/database_service.dart';
import 'package:swift_mobile_app/core/services/shared_preference_singletone.dart';
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
      var resultIfRejected = await _dataBaseService.getData(
        path: BackendEndpoints.rejectedSellers,
        columnName: 'email',
        columnValue: email,
      );
      if (resultIfRejected.isNotEmpty) {
        return Left(ServerFailure('تم رفض حسابك'));
      }
      var user = await _supabaseAuthService.createUserWithEmailAndPassword(
        email: email,
        password: password,
        role: 'seller',
      );

      SellerModel sellerModel = SellerModel(
        id: user.id,
        sellerId: 0,
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
        sellerId: 0,
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
        data: sellerModel.toJsonSignup(),
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
        columnValue: userId,
        columnName: 'id',
        data: {'imageUrl': profilePicUrl},
      );
      return right(null);
    } catch (e) {
      log(e.toString());
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SellerEntity>> loginSeller({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      var resultIfRejected = await _dataBaseService.getData(
        path: BackendEndpoints.rejectedSellers,
        columnName: 'email',
        columnValue: email,
      );
      if (resultIfRejected.isNotEmpty) {
        return Left(ServerFailure('تم رفض حسابك'));
      }
      var pendingResult = await _dataBaseService.getData(
        path: BackendEndpoints.pendingSellers,
        columnName: 'email',
        columnValue: email,
      );
      if (pendingResult.isNotEmpty) {
        return Left(ServerFailure('حسابك قيد المراجعة'));
      }
      var user = await _supabaseAuthService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      var userData = await _dataBaseService.getData(
        path: BackendEndpoints.users,
        columnName: 'id',
        columnValue: user.id,
      );
      var sellerData = await _dataBaseService.getData(
        path: BackendEndpoints.sellers,
        columnName: 'user_id',
        columnValue: user.id,
      );
      log(sellerData.toString());
      SellerModel sellerModel = SellerModel(
        sellerId: sellerData[0]['id'],
        id: userData[0]['id'],
        image: sellerData[0]['image_url'],
        userName: userData[0]['name'],
        email: userData[0]['email'],
        phoneNumber: userData[0]['phone'].toString(),
        storeName: sellerData[0]['store_name'],
        storeAddress: userData[0]['address'],
      );
      SellerEntity sellerEntity = sellerModel.toEntity();
      Prefs.setString(sellerKey, jsonEncode(sellerModel.toJson()));
      if (context.mounted) {
        context.read<UserCubit>().setUser(sellerEntity);
      }
      return Right(sellerEntity);
    } catch (e) {
      log(e.toString());
      return Left(ServerFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, void>> logout() async {
    try {
      _supabaseAuthService.signOut();
      return Right(null);
    } catch (e) {
      log(e.toString());
      return Left(ServerFailure(e.toString()));
    }
  }
}
