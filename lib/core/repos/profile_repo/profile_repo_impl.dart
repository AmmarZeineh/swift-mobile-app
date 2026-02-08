import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:swift_mobile_app/core/errors/failure.dart';
import 'package:swift_mobile_app/core/repos/profile_repo/profile_repo.dart';
import 'package:swift_mobile_app/core/services/backend_endpoints.dart';
import 'package:swift_mobile_app/core/services/database_service.dart';
import 'package:swift_mobile_app/features/seller/auth/domain/entity/seller_entity.dart';

class ProfileRepoImpl implements ProfileRepo {
  final DataBaseService _dataBaseService;

  ProfileRepoImpl(this._dataBaseService);
  @override
  Future<Either<Failure, void>> editProfileDetails(
    Map<String, dynamic> newData,
    String columnName,
    String columnValue,
  ) async {
    try {
      await _dataBaseService.updateData(
        path: BackendEndpoints.users,
        data: newData,
        columnName: columnName,
        columnValue: columnValue,
      );
      return Right(null);
    } catch (e) {
      log(e.toString());
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> editSellerDetails(
    SellerEntity sellerEntity,
    Map<String, dynamic> newData,
    String columnName,
    String columnValue,
  ) async {
    try {
      await _dataBaseService.updateData(
        path: BackendEndpoints.sellers,
        data: newData,
        columnName: columnName,
        columnValue: columnValue,
      );
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
