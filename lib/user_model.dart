import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String name;
  String job;
  String id;
 
  UserModel({
   required this.name,
   required this.job,
   required this.id,
   });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    name: json["name"],
    job: json["job"],
    id: json["id"],
   );

  Map<String, dynamic> toJson() => {
    "name": name,
    "job": job,
    "id": id,
   };
}