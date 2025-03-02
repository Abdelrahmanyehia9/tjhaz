import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable{
  final String id;
  final String title;
  final String? image;
  final String pID ;
  final bool? isNew ;
  final bool? hotOffer ;

  const CategoryModel({ required this.id,required this.title, this.image,required this.pID , this.hotOffer, this.isNew});

  factory CategoryModel.fromJson(Map<String,dynamic> json){
    return CategoryModel(
      id: json['id'],
      title: json['name'],
      image: json['image'],
      pID: json['pID'] ,
      hotOffer: json['hotOffer'],
      isNew: json['isNew']
    );
  }
  Map<String,dynamic> toJson(){
    return {
      'id':id,
      'name':title,
      'image':image,
      'pID':pID
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id,title,image,pID,hotOffer,isNew] ;



}