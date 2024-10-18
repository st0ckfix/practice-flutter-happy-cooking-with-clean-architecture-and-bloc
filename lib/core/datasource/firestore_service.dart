import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ReadFireStore<T, Params> {
  Future<T> readDocument({Params? params});
}

class ReadListFireStore<T> extends ReadFireStore<List<DocumentSnapshot<Map<String, dynamic>>>, String> {
  @override
  Future<List<DocumentSnapshot<Map<String, dynamic>>>> readDocument({String? params}) async {
    try {
      final docSnapshot = await FirebaseFirestore.instance.collection(params!).get();
      if (!docSnapshot.docs.isNotEmpty) {
        throw Exception('Document does not exist.');
      }
      return docSnapshot.docs;
    } catch (e) {
      log('Error reading document: $e');
      rethrow;
    }
  }
}

abstract class WriteFirestore {
  Future<void> writeDocument(String collection, String id, Map<String, dynamic> data, {bool merge = false});
}

abstract class UpdateFirestore {
  Future<void> updateDocument(String collection, String id, Map<String, dynamic> data);
}

abstract class DeleteFirestore {
  Future<void> deleteDocument(String collection, String id);
}

abstract class QueryFirestore {
  Future<QuerySnapshot<Map<String, dynamic>>> queryDocument(
    String collection,
    Object field, {
    Object? isEqualTo,
    Object? isNotEqualTo,
    Object? isLessThan,
    Object? isLessThanOrEqualTo,
    Object? isGreaterThan,
    Object? isGreaterThanOrEqualTo,
    Object? arrayContains,
    Iterable<Object?>? arrayContainsAny,
    Iterable<Object?>? whereIn,
    Iterable<Object?>? whereNotIn,
    bool? isNull,
    DocumentSnapshot? startAfterDocument,
    DocumentSnapshot? startAtDocument,
    DocumentSnapshot? endAtDocument,
    DocumentSnapshot? endBeforeDocument,
    int? limit,
  });
}


// Future<void> updateDocument(String collection, String id, Map<String, dynamic> data) async {
//     try {
//       await _firestore.collection(collection).doc(id).update(data);
//       log('Document updated with ID: $id');
//     } catch (e) {
//       log('Error updating document: $e');
//       rethrow;
//     }
//   }

//   Future<void> deleteDocument(String collection, String id) async {
//     try {
//       final docSnapshot = await _firestore.collection(collection).doc(id).get();
//       if (!docSnapshot.exists) {
//         throw Exception('Document with ID $id does not exist, cannot delete.');
//       }
//       await _firestore.collection(collection).doc(id).delete();
//       log('Document deleted with ID: $id');
//     } catch (e) {
//       log('Error deleting document: $e');
//       rethrow;
//     }
//   }

//   Future<QuerySnapshot<Map<String, dynamic>>> queryDocument(
//     String collection,
//     Object field, {
//     Object? isEqualTo,
//     Object? isNotEqualTo,
//     Object? isLessThan,
//     Object? isLessThanOrEqualTo,
//     Object? isGreaterThan,
//     Object? isGreaterThanOrEqualTo,
//     Object? arrayContains,
//     Iterable<Object?>? arrayContainsAny,
//     Iterable<Object?>? whereIn,
//     Iterable<Object?>? whereNotIn,
//     bool? isNull,
//     DocumentSnapshot? startAfterDocument, // Start after document
//     DocumentSnapshot? startAtDocument, // Start at document
//     DocumentSnapshot? endAtDocument, // End at document
//     DocumentSnapshot? endBeforeDocument, // End before document
//     int? limit, // Limit the number of results
//   }) async {
//     // Build the query
//     Query<Map<String, dynamic>> query = _firestore.collection(collection);

//     // Add 'where' clause if conditions are provided
//     query = query.where(
//       field,
//       isEqualTo: isEqualTo,
//       isNotEqualTo: isNotEqualTo,
//       isLessThan: isLessThan,
//       isLessThanOrEqualTo: isLessThanOrEqualTo,
//       isGreaterThan: isGreaterThan,
//       isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
//       arrayContains: arrayContains,
//       arrayContainsAny: arrayContainsAny,
//       whereIn: whereIn,
//       whereNotIn: whereNotIn,
//       isNull: isNull,
//     );

//     // Apply pagination conditions if provided
//     if (startAfterDocument != null) {
//       query = query.startAfterDocument(startAfterDocument);
//     }
//     if (startAtDocument != null) {
//       query = query.startAtDocument(startAtDocument);
//     }
//     if (endAtDocument != null) {
//       query = query.endAtDocument(endAtDocument);
//     }
//     if (endBeforeDocument != null) {
//       query = query.endBeforeDocument(endBeforeDocument);
//     }

//     // Apply limit if provided
//     if (limit != null) {
//       query = query.limit(limit);
//     }

//     // Return the result
//     return await query.get();
//   }