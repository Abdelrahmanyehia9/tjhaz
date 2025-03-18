import 'package:tjhaz/core/extention/localized_map.dart';

class HomeModel {
  final String id;
  final String imgUrl;
  final Map<String , dynamic>? name ;
  HomeModel({required this.id, required this.imgUrl , this.name});
  factory HomeModel.fromJson(Map<String, dynamic>json)=>HomeModel(id: json["id"] ,  imgUrl: json["images"][0]   ,
    name: (json["name"] as Map<String, dynamic>),
  );
}


