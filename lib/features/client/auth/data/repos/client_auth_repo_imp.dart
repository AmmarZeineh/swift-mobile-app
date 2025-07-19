import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift_mobile_app/core/cubits/user_cubit/user_cubit.dart';
import 'package:swift_mobile_app/core/errors/failure.dart';
import 'package:swift_mobile_app/core/services/backend_endpoints.dart';
import 'package:swift_mobile_app/core/services/database_service.dart';
import 'package:swift_mobile_app/core/services/shared_preference_singletone.dart';
import 'package:swift_mobile_app/core/services/supabase_auth_service.dart';
import 'package:swift_mobile_app/features/client/auth/data/models/client_model.dart';
import 'package:swift_mobile_app/features/client/auth/domain/entities/client_entity.dart';
import 'package:swift_mobile_app/features/client/auth/domain/repos/client_auth_repo.dart';
import 'package:swift_mobile_app/main.dart';

import '../../../../../constants.dart';

class ClientAuthRepoImp implements ClientAuthRepo {
  final SupabaseAuthService _supabaseAuthService;

  final DataBaseService dataBaseServic;

  ClientAuthRepoImp(this.dataBaseServic, this._supabaseAuthService);

  @override
  Future<Either<Failure, ClientEntity>> signupClient(
    String userName,
    String email,
    String password,
    String phoneNumber,
    String gender,
    int age,
  ) async {
    try {
      // التسجيل في Supabase Auth
      var user = await _supabaseAuthService.createUserWithEmailAndPassword(
        email: email,
        password: password,
        role: 'client',
      );

      ClientEntity clientEntity = ClientEntity(
        id: user.id,
        userName: userName,
        email: email,
        phoneNumber: phoneNumber,
      );
      await dataBaseServic.addData(
        path: BackendEndpoints.users,
        data: {
          'id': user.id,
          'name': userName,
          'email': email,
          'phone': phoneNumber,
          'user_type': 'client',
          'gender': gender,
          'age': age,
        },
      );
      return Right(clientEntity);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ClientEntity>> loginClient({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      // التسجيل في Supabase Auth
      var user = await _supabaseAuthService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      var userDetails = await dataBaseServic.getData(
        path: BackendEndpoints.users,
        columnName: 'id',
        columnValue: user.id,
      );
      log(userDetails.toString());
      ClientModel clientModel = ClientModel(
        id: user.id,
        userName: userDetails[0]['name'],
        email: email,
        phoneNumber: userDetails[0]['phone'].toString(),
      );

      ClientEntity clientEntity = ClientEntity(
        id: user.id,
        userName: userDetails[0]['name'],
        email: email,
        phoneNumber: userDetails[0]['phone'].toString(),
      );

      Prefs.setString(clientKey, jsonEncode(clientModel.toJson()));

      if (context.mounted) {
        context.read<AppSessionCubit>().setUser(clientEntity, 'client');
        context.read<UserCubit>().setUser(clientEntity);
      }

      return Right(clientEntity);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
