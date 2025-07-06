import 'package:dartz/dartz.dart';
import 'package:swift_mobile_app/core/errors/failure.dart';
import 'package:swift_mobile_app/features/seller/auth/domain/entity/seller_entity.dart';

abstract class SellerProfileRepo {
  Future<Either<Failure, void>> editProfileDetails(
    SellerEntity sellerEntity,
    Map<String, dynamic> newData,
    String columnName,
       String columnValue

  );

  Future<Either<Failure, void>> editSellerDetails(
    SellerEntity sellerEntity,
    Map<String, dynamic> newData,
    String columnName,
    String columnValue,
  );
}
