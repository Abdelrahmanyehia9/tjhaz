import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tjhaz/core/extention/firebase_exception_handler.dart';
import '../../../../core/database/local/shared_prefrences_constants.dart';
import '../../../../core/database/local/shared_prefrences_helper.dart';
import '../../../../core/database/remote/firestore_constants.dart';
import '../model/bookings_model.dart';

class BookingRepository {
  final FirebaseFirestore firestore;

  const BookingRepository(this.firestore);

  Future<Either<List<int>?, String>> getReservedDaysByEnterID({
    required String month,
    required String entertainmentID,
  }) async {
    try {
      final response = await firestore
          .collection(FireStoreConstants.entertainment)
          .doc(entertainmentID)
          .get().timeout(const Duration(seconds: 10));

      if (!response.exists) return left(null);

      final data = response.data();
      if (data == null || !data.containsKey("reserved_days")) return left(null);

      final reservedDays = data["reserved_days"];
      if (reservedDays is List) {
        return left(List<int>.from(reservedDays));
      }

      return left(null);
    } catch (e) {
      return right(e.firebaseErrorMessage);
    }
  }

  Future<Either<List<int>?, String>> getReservedHoursByEnterID({
    required String month,
    required String entertainmentID,
    required int day,
  }) async {
    try {
      final response = await firestore
          .collection(FireStoreConstants.entertainment)
          .doc(entertainmentID)
          .get();

      if (!response.exists) return left(null);

      final data = response.data();
      if (data == null || !data.containsKey("reserved_hours")) {
        return left(null);
      }

      final reservedHoursMap = data["reserved_hours"];
      if (reservedHoursMap is! Map) return left(null);

      final reservedHoursList = reservedHoursMap[day.toString()];
      if (reservedHoursList is List) {
        return left(List<int>.from(reservedHoursList));
      }

      return left(null);
    } catch (e) {
      return right(e.firebaseErrorMessage);
    }
  }

  Future<bool> hasPendingBooking(String userID) async {
    final response = await firestore
        .collection(FireStoreConstants.bookingsCollection)
        .where("userId", isEqualTo: userID)
        .get();

    return response.docs.isNotEmpty;
  }

  Future<void> bookingNewEntertainment(BookingModel booking) async {
    final bookingDoc = await firestore.collection(FireStoreConstants.bookingsCollection).doc().get();
    await firestore.collection(FireStoreConstants.bookingsCollection).doc(bookingDoc.id).set(
        booking.toJson(bookingDoc.id));
  }

  Future<Either<List<BookingModel>, String>> getAllBookingsByCategory(String? categoryId) async {
    final userId = SharedPrefHelper.getString(SharedPrefConstants.currentUserId);

    try {
      List<BookingModel> allBookings = [];

      Query<Map<String, dynamic>> query = firestore.collection(FireStoreConstants.bookingsCollection)
          .where("userId", isEqualTo: userId)
          .limit(5);

      if (categoryId != null) {
        query = query.where("categoryId", isEqualTo: categoryId);
      }

      final response = await query.get();

      for (var item in response.docs) {
        allBookings.add(BookingModel.fromJson(item.data()));
      }

      return left(allBookings);
    } catch (e) {
      return right(e.firebaseErrorMessage);
    }
  }

  Future<void> cancelBooking(String id) async {
    await firestore.collection(FireStoreConstants.bookingsCollection).doc(id).delete();
  }
}