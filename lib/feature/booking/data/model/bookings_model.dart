import 'package:cloud_firestore/cloud_firestore.dart';

class BookingsModel {
  final String bookingId;
  final Timestamp createdAt;
  final Timestamp date;
  final Timestamp startTime;
  final int numOfHours;
  final String entertainmentID;
  final String status;
  final double totalPrice;
  final String userId;

  BookingsModel({
    required this.bookingId,
    required this.createdAt,
    required this.date,
    required this.startTime,
    required this.numOfHours,
    required this.entertainmentID,
    required this.status,
    required this.totalPrice,
    required this.userId,
  });

  factory BookingsModel.fromJson(Map<String , dynamic> json) {
    return BookingsModel(
      bookingId: json["bookingId"],
      createdAt: json['createdAT'] as Timestamp,
      date: json['date'] as Timestamp,
      startTime: json['startTime'] as Timestamp,
      numOfHours: json['numOfHours'] as int,
      entertainmentID: json['entertainmentID'] as String,
      status: json['status'] as String,
      totalPrice: double.parse(json['totalPrice'].toString()),
      userId: json['userId'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "createdAT": createdAt,
      "date": date,
      "startTime": startTime,
      "endTime": numOfHours,
      "entertainmentID": entertainmentID,
      "status": status,
      "totalPrice": totalPrice.toString(),
      "userId": userId,
    };
  }
}
