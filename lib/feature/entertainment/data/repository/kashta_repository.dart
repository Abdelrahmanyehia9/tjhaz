import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tjhaz/feature/entertainment/data/model/entertainment_model.dart';

import '../../../../core/database/remote/fireStore_constants.dart';
import '../../../../core/database/remote/firestore_errorHandler.dart';

class KashtaRepository{
  FirebaseFirestore firestore ;
  KashtaRepository({required this.firestore});
  Future<Either<EntertainmentModel , String>>getKashtaByID({required String kashtaID })async{
    try{
      DocumentSnapshot<Map<String, dynamic>> response = await firestore.collection(FireStoreConstants.kashtaCollection).doc(kashtaID).get() ;
      EntertainmentModel kashta = EntertainmentModel.fromJson(response.data()!) ;
      return left(kashta) ;
    }catch(e){
      if(e is FirebaseException){
        return right(FirestoreErrorHandler.getErrorMessage(e.code)) ;
      }else{
        return right(FirestoreErrorHandler.getErrorMessage(e.toString())) ;
      }
    }


  }













}