// import 'dart:io';

// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:swift_mobile_app/app_keys.dart';
// import 'package:swift_mobile_app/core/services/storage_service.dart';

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
