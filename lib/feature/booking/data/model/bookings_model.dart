import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class BookingModel extends Equatable {
  final String name;
  final String bookingId;
  final Timestamp createdAt;
  final String? location;
  final int? guests;
  final String imgUrl;
  final String date;
  final int startTime;
  final String catID;
  final int numOfHours;
  final String entertainmentID;
  final String status;
  double? totalPrice;
  final String userId;

  BookingModel({
    required this.name,
    required this.imgUrl,
    this.guests,
    required this.catID,
    this.location,
    required this.bookingId,
    required this.createdAt,
    required this.date,
    required this.startTime,
    required this.numOfHours,
    required this.entertainmentID,
    required this.status,
    this.totalPrice,
    required this.userId,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      name: json["name"] as String,
      bookingId: json["bookingId"] as String,
      imgUrl: json["image"] as String,
      catID: json["categoryId"] as String,
      guests: json["guests"] != null ? json["guests"] as int : null,
      location: json["location"] != null ? json["location"] as String : null,
      createdAt: json['createdAT'] as Timestamp,
      date: json['date'] as String,
      startTime: json['startTime'] as int,
      numOfHours: json['numOfHours'] as int,
      entertainmentID: json['entertainmentID'] as String,
      status: json['status'] as String,
      totalPrice: json['totalPrice'] != null ? double.tryParse(json['totalPrice'].toString()) ?? 0.0 : 0.0,
      userId: json['userId'] as String,
    );
  }

  Map<String, dynamic> toJson(id) {
    return {
      "bookingId": id,
      "createdAT": createdAt,
      "date": date,
      "startTime": startTime,
      "name": name,
      "entertainmentID": entertainmentID,
      "status": status,
      "totalPrice": totalPrice != null ? totalPrice.toString() : "0.0",
      "userId": userId,
      "image": imgUrl,
      "location": location ?? "Unknown",
      "numOfHours": numOfHours,
      "guests": guests ?? 0,
      "categoryId": catID,
    };
  }

  @override
  List<Object?> get props => [
    bookingId,
    createdAt,
    date,
    startTime,
    numOfHours,
    entertainmentID,
    status,
    totalPrice,
    userId
  ];
}
