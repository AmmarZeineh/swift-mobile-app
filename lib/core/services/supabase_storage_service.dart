// import 'dart:io';

// import 'package:fannyk/app_keys.dart';
// import 'package:fannyk/core/services/backend_endpoints.dart';
// import 'package:fannyk/core/services/storage_service.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:path/path.dart' as b;

// class SupabaseStorageService extends StorageService {
//   SupabaseClient supabase = SupabaseClient(AppKeys.url, AppKeys.anonKey);

//   @override
//   Future<String> uploadFile(File file, String path) async {
//     var fileName = b.basename(file.path);
//     await supabase.storage
//         .from(BackendEndpoints.images)
//         .upload('$path/$fileName', file);
//     var url = supabase.storage
//         .from(BackendEndpoints.images)
//         .getPublicUrl('$path/$fileName');
//     return url;
//   }
// }
