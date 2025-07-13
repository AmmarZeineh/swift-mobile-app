import 'package:dartz/dartz.dart';
import 'package:swift_mobile_app/core/errors/failure.dart';
import 'package:swift_mobile_app/features/client/auth/domain/entities/client_entity.dart';

abstract class CLientProfileRepo {
  Future<Either<Failure, void>> editProfileDetails(
    ClientEntity clientEntity,
    Map<String, dynamic> newData,
    String columnName,
    String columnValue,
  );
}
