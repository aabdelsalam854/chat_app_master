abstract class DatabaseServices {
  Future<void> addData(
      {String? docId,
      required String path,
      required Map<String, dynamic> data});
  Future<dynamic> updateData(
      {required String path, required Map<String, dynamic> data  ,required String? docId,});
  Future<void> deleteData({required String path});
  Future<void> setData(
      {required String path, required Map<String, dynamic> data});

  Future<Map<String, dynamic>> getData(
      {required String path, required String docId});
  Future<List<Map<String, dynamic>>> getAllDocuments(String collectionPath);
}
