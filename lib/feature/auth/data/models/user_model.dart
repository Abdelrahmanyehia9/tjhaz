class UserModel {
  final String uID;
  final String username;
  final String emailAddress;
  final String? birthDate ;

  UserModel(
      {required this.uID, required this.username, required this.emailAddress , this.birthDate});

  factory UserModel.fromJson(Map<String, dynamic>json)=> UserModel(uID: json['userID'],
          username: json['username'],
          emailAddress: json['email'] ,
           birthDate:  json['birthDate']


  );
  Map<String , dynamic>toJson()=>{
    "username":username ,
    "email":emailAddress ,
    "userID":uID ,
    "birthDate":birthDate
  } ;


}