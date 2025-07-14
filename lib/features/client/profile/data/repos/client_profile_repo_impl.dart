import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:swift_mobile_app/core/errors/failure.dart';
import 'package:swift_mobile_app/core/services/backend_endpoints.dart';
import 'package:swift_mobile_app/core/services/database_service.dart';
import 'package:swift_mobile_app/features/client/auth/domain/entities/client_entity.dart';
import 'package:swift_mobile_app/features/client/profile/domain/repos/client_profile_repo.dart';

class ClientProfileRepoImpl implements CLientProfileRepo {
  final DataBaseService _dataBaseService;

  ClientProfileRepoImpl(this._dataBaseService);
  @override
  Future<Either<Failure, void>> editProfileDetails(
    ClientEntity clientEntity,
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
}
