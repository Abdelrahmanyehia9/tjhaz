import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tjhaz/core/routes/index.dart';

class FavoriteModel {
  final EntertainmentDetailsModel model;

  final Timestamp addedDate;

  FavoriteModel(this.model, this.addedDate);

  factory FavoriteModel.fromJson(Map<String, dynamic> json) => FavoriteModel(
      EntertainmentDetailsModel.fromJson(json["model"]), json["addedDate"]);

  Map<String, dynamic> toJson() =>
      {"model": model.toJson(), "addedDate": addedDate};
}
