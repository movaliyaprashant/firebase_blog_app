// To parse this JSON data, do
//
//     final blogDataModel = blogDataModelFromJson(jsonString);

import 'dart:convert';

class UserDataModel {
  UserDataModel({
    this.userName,
   required this.emailId,

  });

  String? userName;
  String emailId;


  factory UserDataModel.fromRawJson(String str) => UserDataModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
    userName: json["userName"] == null ? null : json["userName"],
    emailId: json["email_id"] == null ? null : json["email_id"],

  );

  Map<String, dynamic> toJson() => {
    "userName": userName == null ? null : userName,
    "email_id": emailId == null ? null : emailId,

  };
}
