

abstract class DatabaseServices {
  Future<void> addData(
      {      String? docId  ,required String path, required Map<String, dynamic> data});
  Future<void> updateData(
      {required String path, required Map<String, dynamic> data});
  Future<void> deleteData({required String path});
  Future<void> setData(
      {required String path, required Map<String, dynamic> data});

  Future<Map<String, dynamic>> getData({required String path, required String docId});
}
