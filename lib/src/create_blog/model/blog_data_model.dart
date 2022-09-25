// To parse this JSON data, do
//
//     final blogDataModel = blogDataModelFromJson(jsonString);

import 'dart:convert';

class BlogDataModel {
  BlogDataModel({
    this.userName,
    this.emailId,
   required this.title,
    required this.description,
   required this.category,
    this.image,
  });

  String? userName;
  String? emailId;
  String title;
  String description;
  String category;
  String? image;

  factory BlogDataModel.fromRawJson(String str) => BlogDataModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BlogDataModel.fromJson(Map<String, dynamic> json) => BlogDataModel(
    userName: json["userName"] == null ? null : json["userName"],
    emailId: json["email_id"] == null ? null : json["email_id"],
    title: json["title"] == null ? null : json["title"],
    description: json["description"] == null ? null : json["description"],
    category: json["category"] == null ? null : json["category"],
    image: json["image"] == null ? null : json["image"],
  );

  Map<String, dynamic> toJson() => {
    "userName": userName == null ? null : userName,
    "email_id": emailId == null ? null : emailId,
    "title": title == null ? null : title,
    "description": description == null ? null : description,
    "category": category == null ? null : category,
    "image": image == null ? null : image,
  };
}
