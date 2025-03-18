import 'package:cloud_firestore/cloud_firestore.dart';

extension FirestoreCacheHelper on FirebaseFirestore {
  Future<DocumentSnapshot<Map<String, dynamic>>> getDocumentWithCache(
      String collectionPath, String docId) async {
    final cacheResponse = await collection(collectionPath)
        .doc(docId)
        .get(const GetOptions(source: Source.cache));

    if (cacheResponse.exists) {
      return cacheResponse;
    }

    return await collection(collectionPath)
        .doc(docId)
        .get(const GetOptions(source: Source.server));
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getCollectionWithCache(
      String collectionPath) async {
    final cacheResponse = await collection(collectionPath)
        .get(const GetOptions(source: Source.cache));
    if (cacheResponse.docs.isNotEmpty) {
      return cacheResponse;
    }

    return await collection(collectionPath)
        .get(const GetOptions(source: Source.server));
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getCollectionWithWhereCache(
      String collectionPath,
      String field,
      dynamic value,
      {String? operator = '==',
        int? limit}) async {

    Query<Map<String, dynamic>> query = collection(collectionPath);

    switch(operator) {
      case '==': query = query.where(field, isEqualTo: value); break;
      case '!=': query = query.where(field, isNotEqualTo: value); break;
      case '>': query = query.where(field, isGreaterThan: value); break;
      case '>=': query = query.where(field, isGreaterThanOrEqualTo: value); break;
      case '<': query = query.where(field, isLessThan: value); break;
      case '<=': query = query.where(field, isLessThanOrEqualTo: value); break;
      case 'array-contains': query = query.where(field, arrayContains: value); break;
    }

    if (limit != null) {
      query = query.limit(limit);
    }

    final cacheResponse = await query.get(const GetOptions(source: Source.cache));
    if (cacheResponse.docs.isNotEmpty) {
      return cacheResponse;
    }

    return await query.get(const GetOptions(source: Source.server));
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getCollectionWithMultiWhereCache(
      String collectionPath,
      List<Map<String, dynamic>> conditions,
      {int? limit}) async {

    Query<Map<String, dynamic>> query = collection(collectionPath);

    for (var condition in conditions) {
      String field = condition['field'];
      dynamic value = condition['value'];
      String operator = condition['operator'] ?? '==';

      switch(operator) {
        case '==': query = query.where(field, isEqualTo: value); break;
        case '!=': query = query.where(field, isNotEqualTo: value); break;
        case '>': query = query.where(field, isGreaterThan: value); break;
        case '>=': query = query.where(field, isGreaterThanOrEqualTo: value); break;
        case '<': query = query.where(field, isLessThan: value); break;
        case '<=': query = query.where(field, isLessThanOrEqualTo: value); break;
        case 'array-contains': query = query.where(field, arrayContains: value); break;
      }
    }

    if (limit != null) {
      query = query.limit(limit);
    }

    final cacheResponse = await query.get(const GetOptions(source: Source.cache));
    if (cacheResponse.docs.isNotEmpty) {
      return cacheResponse;
    }

    return await query.get(const GetOptions(source: Source.server));
  }
}