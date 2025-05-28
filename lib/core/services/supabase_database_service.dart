import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:swift_mobile_app/core/errors/exceptions.dart';
import 'package:swift_mobile_app/core/services/database_service.dart';

class SupabaseDatabaseService extends DataBaseService {
  final _supabase = Supabase.instance.client;

  @override
  Future<void> addData({
    required String path,
    required Map<String, dynamic> data,
    String? docId,
  }) async {
    try {
      await _supabase.from(path).insert(data);
    } catch (e) {
      throw CustomException(message: e.toString());
    }
  }

  @override
  Future getData({
    required String path,
    String? docId,
    Map<String, dynamic>? query,
  }) async {
    try {
      if (docId == null) {
        return await _supabase.from(path).select();
      } else {
        return await _supabase.from(path).select().eq('id', docId);
      }
    } catch (e) {
      throw CustomException(message: e.toString());
    }
  }

  @override
  Future<void> updateData({
    required String path,
    required String id,
    required Map<String, dynamic> data,
  }) async {
    try {
      await _supabase.from(path).update(data).eq('id', id);
    } catch (e) {
      log(e.toString());
      throw CustomException(message: e.toString());
    }
  }
}
