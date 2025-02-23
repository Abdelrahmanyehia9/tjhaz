import 'package:dartz/dartz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tjhaz/core/database/remote/fireStore_constants.dart';
import 'package:tjhaz/core/database/remote/firestore_errorHandler.dart';
import 'package:tjhaz/feature/home/data/models/home_model.dart';

class HomeRepository {
  final FirebaseFirestore firestore;
  HomeRepository({required this.firestore});
Future<Either<List<HomeModel>,String>> getTrips()async{

  try{
    List<HomeModel> tripsList = [] ;
    QuerySnapshot<Map<String, dynamic>> response = await firestore.collection(FireStoreConstants.tripsCollection).get() ;
for(var item in response.docs){
  tripsList.add(HomeModel.fromJson(item.data())) ;
}
return left(tripsList) ;

  }catch(e){
    if(e is FirebaseException){
      return right(FirestoreErrorHandler.getErrorMessage(e.code)) ;
    }else{
      return right(FirestoreErrorHandler.getErrorMessage(e.toString())) ;
    }
  }


}
  Future<Either<List<HomeModel>,String>> getActivities()async{

    try{
      List<HomeModel> activitiesList = [] ;
      QuerySnapshot<Map<String, dynamic>> response = await firestore.collection(FireStoreConstants.activitiesCollection).get() ;
      print(response);
      for(var item in response.docs){
        activitiesList.add(HomeModel.fromJson(item.data())) ;
      }
      return left(activitiesList) ;

    }catch(e){
      if(e is FirebaseException){
        return right(FirestoreErrorHandler.getErrorMessage(e.code)) ;
      }else{
        return right(FirestoreErrorHandler.getErrorMessage(e.toString())) ;
      }
    }


  }

}


