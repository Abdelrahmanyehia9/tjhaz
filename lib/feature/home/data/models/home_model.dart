class HomeModel {
  final String id;
  final String imgUrl;
  HomeModel({required this.id, required this.imgUrl});
  factory HomeModel.fromJson(Map<String, dynamic>json)=>HomeModel(id: json["id"] ,  imgUrl: json["images"][0]                   );
}


