class HomeModel {
  final String id;
  final String imgUrl;
  final Map<String , String>? name ;
  HomeModel({required this.id, required this.imgUrl , this.name});
  factory HomeModel.fromJson(Map<String, dynamic>json)=>HomeModel(id: json["id"] ,  imgUrl: json["images"][0]   ,
    name: Map<String, String>.from(json["name"]),
  );
}


