// To parse this JSON data, do
//
//     final categoriesModel = categoriesModelFromJson(jsonString);

import 'dart:convert';

CategoriesModel categoriesModelFromJson(String str) => CategoriesModel.fromJson(json.decode(str));

String categoriesModelToJson(CategoriesModel data) => json.encode(data.toJson());

class CategoriesModel {
  List<CategoriesDatum>? data;
  String? message;
  int? code;

  CategoriesModel({
    this.data,
    this.message,
    this.code,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) => CategoriesModel(
    data: json["data"] == null ? [] : List<CategoriesDatum>.from(json["data"]!.map((x) => CategoriesDatum.fromJson(x))),
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
    "code": code,
  };
}

class CategoriesDatum {
  int? id;
  String? name;
  String? image;

  @override
  String toString() {
    return 'CategoriesDatum{id: $id, name: $name, image: $image}';
  }

  CategoriesDatum({
    this.id,
    this.name,
    this.image,
  });

  factory CategoriesDatum.fromJson(Map<String, dynamic> json) => CategoriesDatum(
    id: json["id"],
    name: json["name"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
  };
}
