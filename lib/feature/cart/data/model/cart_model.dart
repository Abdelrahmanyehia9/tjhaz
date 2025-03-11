import 'package:cloud_firestore/cloud_firestore.dart';

class CartModel {
  final String itemId;
  final Map<String, String> itemTitle;
  final int quantity;
  final double price;
  final String imgUrl;
  final Timestamp addedDate;
  CartModel(this.itemId, this.itemTitle, this.quantity, this.price, this.imgUrl,this.addedDate);

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(json['itemId'], json['itemTitle'], json['quantity'],
        json['price'], json['imgUrl'], json['addedDate']);
  }

  Map<String, dynamic> toJson() {
    return {
      'itemId': itemId,
      'itemTitle': itemTitle,
      'quantity': quantity,
      'price': price,
      'imgUrl': imgUrl,
      'addedDate': addedDate
    };
  }
}
