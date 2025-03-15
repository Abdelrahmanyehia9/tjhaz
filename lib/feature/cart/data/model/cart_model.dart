import 'package:cloud_firestore/cloud_firestore.dart';

class CartModel {
  final Timestamp addedDate;

  final Map<String, dynamic> itemName;

  final String itemID;

  final String itemImage;

  final double itemPrice;

  final int itemQuantity;

  CartModel(
      {required this.addedDate,
      required this.itemName,
      required this.itemID,
      required this.itemImage,
      required this.itemPrice,
      required this.itemQuantity});


  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
      addedDate: json['addedDate'],
      itemName: json['itemName'],
      itemID: json['itemID'],
      itemImage: json['itemImage'],
      itemPrice: double.parse(json['itemPrice']),
      itemQuantity: json['itemQuantity']);
  Map<String, dynamic> toJson() => {
        'addedDate': addedDate,
        'itemName': itemName,
        'itemID': itemID,
        'itemImage': itemImage,
        'itemPrice': itemPrice.toString(),
        'itemQuantity': itemQuantity
  } ;
}


