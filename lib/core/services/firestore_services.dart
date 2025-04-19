import 'package:cloud_firestore/cloud_firestore.dart';

import 'database_services.dart';

class FirestoreServices implements DatabaseServices {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<void> addData(
      {required String path,
      required Map<String, dynamic> data,
      String? docId}) async {
    if (docId != null) {
      await firestore.collection(path).doc(docId).set(data);
    } else {
      await firestore.collection(path).add(data);
    }
  }

  @override
  Future<void> deleteData({required String path}) async {
    await firestore.collection(path).doc().delete();
  }

  @override
  Future<void> setData(
      {required String path, required Map<String, dynamic> data}) {
    // TODO: implement setData
    throw UnimplementedError();
  }

  @override
  Future<dynamic> updateData(
      {required String path,
      required Map<String, dynamic> data,
      required String? docId}) async {
    await firestore.collection(path).doc(docId).update(data);
    return data;
  }

  @override
  Future<Map<String, dynamic>> getData(
      {required String path, required String docId}) async {
    var userData = await firestore.collection(path).doc(docId).get();
    return userData.data() as Map<String, dynamic>;
  }

  @override
  Future<List<Map<String, dynamic>>> getAllDocuments(
      String collectionPath) async {
    final snapshot =
        await FirebaseFirestore.instance.collection(collectionPath).get();

    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  @override
  Stream<QuerySnapshot<Object?>> getCollectionStream(String collectionPath) {
    final stream =
        FirebaseFirestore.instance.collection(collectionPath).snapshots();
    return stream;
  }
}
