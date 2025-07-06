import 'dart:developer';
import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:path/path.dart' as b;
import 'package:swift_mobile_app/core/services/storage_service.dart';

import '../../app_keys.dart';

class SupabaseStorageService extends StorageService {
  SupabaseClient supabase = SupabaseClient(AppKeys.url, AppKeys.annon);

  @override
  Future<String> uploadFile(File file, String path, String backEnd) async {
    var fileName = b.basename(file.path);
    await supabase.storage.from(backEnd).upload('$path/$fileName', file);
    var url = supabase.storage.from(backEnd).getPublicUrl('$path/$fileName');
    return url;
  }

  @override
  Future<void> deleteFile(String path, String backEnd) async {
    var result = await supabase.storage.from(backEnd).remove([path]);

    log(result.toString());
  }
}
