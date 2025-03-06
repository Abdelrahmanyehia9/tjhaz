import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tjhaz/core/extention/firestore_error_message.dart';
import '../../../../core/database/remote/fireStore_constants.dart';
import '../model/bookings_model.dart';

class BookingRepository {
  final FirebaseFirestore firestore;

  const BookingRepository(this.firestore);

  Future<Either<List<int>?, String>> getReservedDaysByEnterID({required String month, required String entertainmentID,}) async {
    try {
      final response = await firestore
          .collection(FireStoreConstants.entertainment)
          .doc(entertainmentID)
          .collection(FireStoreConstants.reservationCollection)
          .doc(month)
          .get();

      if (!response.exists) return left(null);

      final data = response.data();
      if (data == null || !data.containsKey("reserved_days")) return left(null);

      final reservedDays = data["reserved_days"];
      if (reservedDays is List) {
        return left(List<int>.from(reservedDays));
      }

      return left(null); // If the type is incorrect
    } catch (e) {
      return right(e.firestoreErrorMessage);
    }
  }
  Future<Either<List<int>?, String>> getReservedHoursByEnterID(
      {required String month, required String entertainmentID, required int day,
      }) async {
    try {
      final response = await firestore
          .collection(FireStoreConstants.entertainment)
          .doc(entertainmentID)
          .collection(FireStoreConstants.reservationCollection)
          .doc(month)
          .get();

      if (!response.exists) return left(null);

      final data = response.data();
      if (data == null || !data.containsKey("reserved_hours"))
        return left(null);

      final reservedHoursMap = data["reserved_hours"];
      if (reservedHoursMap is! Map) return left(null);

      final reservedHoursList = reservedHoursMap[day.toString()];
      if (reservedHoursList is List) {
        return left(List<int>.from(reservedHoursList));
      }

      return left(null);
    } catch (e) {
      return right(e.firestoreErrorMessage);
    }
  }
  Future<bool>hasPendingBooking(String userID)async{
    final response =  await firestore.collection(FireStoreConstants.bookingsCollection).where("userId",isEqualTo: userID).where("status",isEqualTo: "pending").get() ;
    return response.docs.isNotEmpty ;
  }
  Future<void> bookingNewEntertainment(BookingModel booking) async {
   final bookingDoc = await firestore.collection(FireStoreConstants.bookingsCollection).doc( ).get() ;
    await firestore.collection(FireStoreConstants.bookingsCollection).doc(bookingDoc.id).set(
        booking.toJson(bookingDoc.id));
  }
  Future<Either<List<BookingModel> , String>>getAllBookingsByCategory(String userId , String? categoryId) async{
    try{
      List<BookingModel> allBookings = [] ;
      final QuerySnapshot<Map<String, dynamic>> response ;
      if(categoryId != null){
         response =  await firestore.collection(FireStoreConstants.bookingsCollection).where("userId",isEqualTo: userId).where("categoryId" , isEqualTo: categoryId).limit(5).get() ;
      }else{
         response =  await firestore.collection(FireStoreConstants.bookingsCollection).where("userId",isEqualTo: userId).limit(5).get() ;
      }
      for(var item in response.docs){
        allBookings.add(BookingModel.fromJson(item.data())) ;
      }
      return left(allBookings) ;
    }catch(e){
      print(e.toString()) ;
      return right(e.firestoreErrorMessage) ;
    }



  }
  Future<void>cancelBooking(String id)async{
    await firestore.collection(FireStoreConstants.bookingsCollection).doc(id).delete() ;
}
}