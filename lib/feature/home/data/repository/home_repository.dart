import 'package:dartz/dartz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tjhaz/core/database/remote/fireStore_constants.dart';
import 'package:tjhaz/core/database/remote/firestore_errorHandler.dart';
import 'package:tjhaz/core/extention/firebase_caching_helper.dart';
import 'package:tjhaz/feature/entertainment/data/model/entertainment_details_model_constants.dart';
import 'package:tjhaz/feature/home/data/models/banner_model.dart';
import 'package:tjhaz/feature/home/data/models/home_model.dart';

class HomeRepository {
  final FirebaseFirestore firestore;
  HomeRepository({required this.firestore});

  Future<Either<List<HomeModel>, String>> getTrips({int limit = 4}) async {
    return _fetchHomeData(FireStoreConstants.entertainment, EntertainmentDetailsModelConstants.entertainmentType, "1", limit);
  }

  Future<Either<List<HomeModel>, String>> getActivities({int limit = 4}) async {
    return _fetchHomeData(FireStoreConstants.entertainment, EntertainmentDetailsModelConstants.entertainmentType, "3", limit);
  }

  Future<Either<List<HomeModel>, String>> getAllStores({int limit = 4}) async {
    return _fetchHomeData(FireStoreConstants.storesCollection, null, null, limit);
  }

  Future<Either<List<BannerModel>, String>> getAllBanners() async {
    try {
      final response = await firestore.getCollectionWithCache(FireStoreConstants.bannersCollection);
      final banners = response.docs.map((item) => BannerModel.fromJson(item.data())).toList();
      return left(banners);
    } catch (e) {
      return right(_handleError(e));
    }
  }

  Future<Either<List<HomeModel>, String>> _fetchHomeData(
      String collection, String? field, String? value, int limit) async {
    try {
      QuerySnapshot<Map<String, dynamic>> response;
      if (field != null && value != null) {
        response = await firestore.getCollectionWithWhereCache(collection, field, value, limit: limit);
      } else {
        response = await firestore.getCollectionWithCache(collection);
      }

      final dataList = response.docs.map((item) => HomeModel.fromJson(item.data())).toList();
      return left(dataList);
    } catch (e) {
      return right(_handleError(e));
    }
  }

  String _handleError(dynamic e) {
    return e is FirebaseException ? FirestoreErrorHandler.getErrorMessage(e.code) : e.toString();
  }
}
