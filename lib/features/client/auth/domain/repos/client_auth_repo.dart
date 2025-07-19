import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:swift_mobile_app/core/errors/failure.dart';
import 'package:swift_mobile_app/features/client/auth/domain/entities/client_entity.dart';

abstract class ClientAuthRepo {
  Future<Either<Failure, ClientEntity>> signupClient(
    String userName,
    String email,
    String password,
    String phoneNumber,
    String gender,
    int age,
  );

  Future<Either<Failure, ClientEntity>> loginClient({
    required String email,
    required String password,
    required BuildContext context
  });
}