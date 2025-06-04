import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:swift_mobile_app/core/errors/failure.dart';
import 'package:swift_mobile_app/features/seller/auth/domain/entity/seller_entity.dart';

abstract class SellerAuthRepo {
  Future<Either<Failure, SellerEntity>> signupSeller(
    String userName,
    String email,
    String password,
    String phoneNumber,
    String storeName,
    String storeAddress,
    File image,
  );
  Future<Either<Failure, void>> updateSellerProfilePic({
    required String userId,
    required String profilePicUrl,
  });

   Future<Either<Failure, SellerEntity>> loginSeller({
    required String email,
    required String password,
  });
}
