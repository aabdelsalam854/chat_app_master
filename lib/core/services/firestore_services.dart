import 'package:cloud_firestore/cloud_firestore.dart';

import 'database_services.dart';

class FirestoreServices implements DatabaseServices {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<void> addData(
      {required String path,
      required Map<String, dynamic> data,
      String? subCollectionPath,
      String? docId}) async {
    if (subCollectionPath != null && docId != null) {
      await firestore
          .collection(path)
          .doc(docId)
          .collection(subCollectionPath)
          .add(data);
      return;
    }

    await firestore.collection(path).add(data);
  }

  @override
  Future<void> deleteData({required String path}) async {
    await firestore.collection(path).doc().delete();
  }

  @override
  Future<void> setData(
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
  Future<dynamic> updateData(
      {required String path,
      required Map<String, dynamic> data,
      required String? docId}) async {
    await firestore.collection(path).doc(docId).update(data);
    return data;
  }

  @override
  Future<Map<String, dynamic>?> getData({
    required String path,
    required String docId,
  }) async {
    final doc = await firestore.collection(path).doc(docId).get();
    return doc.exists ? doc.data() : null;
  }

  @override
  Future<List<Map<String, dynamic>>> getAllDocuments(
      String collectionPath) async {
    final snapshot = await firestore.collection(collectionPath).get();

    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  @override
  Stream<QuerySnapshot<Object?>> getCollectionStream({
    required String collectionPath,
    String? docId,
    String? subCollectionPath,
    String? orderByField,
    bool descending = false,
    int? limit,
  }) {
    CollectionReference collectionRef = firestore.collection(collectionPath);
    Query query;
    if (docId != null && subCollectionPath != null) {
      query = collectionRef.doc(docId).collection(subCollectionPath);
    } else {
      query = collectionRef;
    }
    if (orderByField != null) {
      query = query.orderBy(orderByField, descending: descending);
    }
    if (limit != null) {
      query = query.limit(limit);
    }
    return query.snapshots();
  }
}
