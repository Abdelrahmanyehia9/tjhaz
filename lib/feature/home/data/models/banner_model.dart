class BannerModel{
  final String image ;
  final String? action ;

  BannerModel({required this.image ,  this.action}) ;
  factory BannerModel.fromJson(Map<String , dynamic> json) => BannerModel(image: json['image'] , action: json['action']) ;
  Map<String , dynamic> toJson() => {'image' : image , 'action' : action} ;

}