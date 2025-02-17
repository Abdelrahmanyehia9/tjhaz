class UserModel {
  final String uID;
  final String username;
  final String emailAddress;

  UserModel(
      {required this.uID, required this.username, required this.emailAddress});

  factory UserModel.fromJson(Map<String, dynamic>json)=> UserModel(uID: json['userID'],
          username: json['username'],
          emailAddress: json['email']);
  Map<String , dynamic>toJson()=>{
    "username":username ,
    "email":emailAddress ,
    "userID":uID
  } ;


}