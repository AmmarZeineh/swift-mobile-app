abstract class DataBaseService {
  Future<void> addData({
    required String path,
    required Map<String, dynamic> data,
    String? docId,
  });
  Future<dynamic> getData({
    required String tableName,
    String? docId,
    Map<String, dynamic>? query,
  });

  Future<void> updateData({
    required String path,
    required String id,
    required Map<String, dynamic> data,
  });
}
