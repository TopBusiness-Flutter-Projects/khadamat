// // To parse this JSON data, do
// //
// //     final homeModel = homeModelFromJson(jsonString);
//
// import 'dart:convert';
//
// HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));
//
// String homeModelToJson(HomeModel data) => json.encode(data.toJson());
//
// class HomeModel {
//   final HomeData? data;
//   final String? message;
//   final int? code;
//
//   HomeModel({
//     this.data,
//     this.message,
//     this.code,
//   });
//
//   factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
//     data: json["data"] == null ? null : HomeData.fromJson(json["data"]),
//     message: json["message"],
//     code: json["code"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "data": data?.toJson(),
//     "message": message,
//     "code": code,
//   };
// }
//
// class HomeData {
//   final List<Category>? categories;
//   final List<ServicesModel>? ServicesModels;
//
//   HomeData({
//     this.categories,
//     this.ServicesModels,
//   });
//
//   factory HomeData.fromJson(Map<String, dynamic> json) => HomeData(
//     categories: json["categories"] == null ? [] : List<Category>.from(json["categories"]!.map((x) => Category.fromJson(x))),
//     ServicesModels: json["last_add_services"] == null ? [] : List<ServicesModel>.from(json["last_add_services"]!.map((x) => ServicesModel.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x.toJson())),
//     "last_add_services": ServicesModels == null ? [] : List<dynamic>.from(ServicesModels!.map((x) => x.toJson())),
//   };
// }
//
// class Category {
//   final int? id;
//   final String? name;
//   final String? image;
//
//   Category({
//     this.id,
//     this.name,
//     this.image,
//   });
//
//   factory Category.fromJson(Map<String, dynamic> json) => Category(
//     id: json["id"],
//     name: json["name"],
//     image: json["image"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "image": image,
//   };
// }
//
// class ServicesModel {
//   final String? name;
//   final int? categoryId;
//   final String? logo;
//
//   ServicesModel({
//     this.name,
//     this.categoryId,
//     this.logo,
//   });
//
//   factory ServicesModel.fromJson(Map<String, dynamic> json) => ServicesModel(
//     name: json["name"],
//     categoryId: json["category_id"],
//     logo: json["logo"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "name": name,
//     "category_id": categoryId,
//     "logo": logo,
//   };
// }

// To parse this JSON data, do
//
//     final homeModel = homeModelFromJson(jsonString);

import 'dart:convert';

import 'servicemodel.dart';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

String homeModelToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
  Data? data;
  String? message;
  int? code;

  HomeModel({
    this.data,
    this.message,
    this.code,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "message": message,
    "code": code,
  };
}

class Data {
  List<Category>? categories;
  List<ServicesModel>? servicesModels;

  Data({
    this.categories,
    this.servicesModels,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    categories: json["categories"] == null ? [] : List<Category>.from(json["categories"]!.map((x) => Category.fromJson(x))),
    servicesModels: json["last_add_services"] == null ? [] : List<ServicesModel>.from(json["last_add_services"]!.map((x) => ServicesModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x.toJson())),
    "last_add_services": servicesModels == null ? [] : List<dynamic>.from(servicesModels!.map((x) => x.toJson())),
  };
}

class Category {
  int? id;
  String? name;
  String? image;

  Category({
    this.id,
    this.name,
    this.image,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
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



