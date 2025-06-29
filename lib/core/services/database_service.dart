abstract class DataBaseService {
  Future<void> addData({
    required String path,
    required Map<String, dynamic> data,
    String? docId,
  });
  Future<dynamic> getData({
    required String path,
    String? columnName,
    dynamic columnValue,
    Map<String, dynamic>? query,
  });

  Future<void> updateData({
    required String path,
    required Map<String, dynamic> data,
    required String columnName,
    required dynamic columnValue,
  });

  Future<void> deleteData({
    required String path,
    required String columnName,
    required dynamic columnValue,
  });
}
