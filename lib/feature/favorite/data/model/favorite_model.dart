import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteModel {
  final Timestamp addedDate;

  FavoriteModel(this.addedDate);

  factory FavoriteModel.fromJson(Map<String, dynamic> json) => FavoriteModel(
      json["addedDate"]);

  Map<String, dynamic> toJson() =>
      {"addedDate": addedDate};
}
