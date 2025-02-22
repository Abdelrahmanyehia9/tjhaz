import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/database/remote/fireStore_constants.dart';
import '../../../../core/database/remote/firestore_errorHandler.dart';
import '../model/trip_model.dart';

class TripRepository{

  final FirebaseFirestore firestore;
  TripRepository({required this.firestore});


  Future<Either<TripModel , String>>getTripByID({required String tripID })async{
    try{
      DocumentSnapshot<Map<String, dynamic>> response = await firestore.collection(FireStoreConstants.tripsCollection).doc(tripID).get() ;
      TripModel trip = TripModel.fromJson(response.data()!) ;
      return left(trip) ;
    }catch(e){
      if(e is FirebaseException){
        return right(FirestoreErrorHandler.getErrorMessage(e.code)) ;
      }else{
        return right(FirestoreErrorHandler.getErrorMessage(e.toString())) ;
      }
    }
  }





}