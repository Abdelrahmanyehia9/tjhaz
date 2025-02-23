import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tjhaz/feature/entertainment/data/model/entertainment_model.dart';

import '../../../../core/database/remote/fireStore_constants.dart';
import '../../../../core/database/remote/firestore_errorHandler.dart';

class ActivityRepository {

  final FirebaseFirestore firestore ;
  ActivityRepository({required this.firestore});

  Future<Either<EntertainmentModel , String>>getActivityByID(String activityID )async{
    try{
      DocumentSnapshot<Map<String, dynamic>> response = await firestore.collection(FireStoreConstants.activitiesCollection).doc(activityID).get() ;
      EntertainmentModel activity = EntertainmentModel.fromJson(response.data()!) ;
      return left(activity) ;
    }catch(e){
      if(e is FirebaseException){
        return right(FirestoreErrorHandler.getErrorMessage(e.code)) ;
      }else{
        return right(FirestoreErrorHandler.getErrorMessage(e.toString())) ;
      }
    }
  }






}