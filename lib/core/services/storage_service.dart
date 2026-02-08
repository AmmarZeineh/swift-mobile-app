import 'dart:io';

abstract class StorageService {
  Future<String> uploadFile(File file, String path, String backEnd);
  Future<void> deleteFile(String path, String backEnd);
}
