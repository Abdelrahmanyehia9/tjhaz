import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tjhaz/core/database/remote/fireStore_constants.dart';
import 'package:tjhaz/core/database/remote/firestore_errorHandler.dart';
import 'package:tjhaz/feature/home/data/models/home_model.dart';

class HomeRepository{
  final FirebaseFirestore firestore ;
  HomeRepository({required this.firestore}); 
  
  
  
  Future<Either<List<HomeModel> , String>>getHomeTrips()async{
    List<HomeModel>trips  = []  ;
    try{
      QuerySnapshot<Map<String, dynamic>> response =await firestore.collection(FireStoreConstants.tripsCollection).orderBy("rating_count").limit(4).get() ;
      for(var item in response.docs){
        trips.add(HomeModel.fromJson(item.data())) ;
      }
      return left(trips) ;

    }catch(e){
      if(e is FirebaseException){
        return right(FirestoreErrorHandler.getErrorMessage(e.code)) ;
      }
      return right(FirestoreErrorHandler.getErrorMessage(e.toString())) ;
    }
    
    
    
    
    
    
    
  }
  
  
  
  
  
  
  
  
  
  
  
  
}