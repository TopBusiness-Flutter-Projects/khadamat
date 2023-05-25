// To parse this JSON data, do
//
//     final homeModel = homeModelFromJson(jsonString);

import 'dart:convert';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

String homeModelToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
  final HomeData? data;
  final String? message;
  final int? code;

  HomeModel({
    this.data,
    this.message,
    this.code,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
    data: json["data"] == null ? null : HomeData.fromJson(json["data"]),
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "message": message,
    "code": code,
  };
}

class HomeData {
  final List<Category>? categories;
  final List<LastAddService>? lastAddServices;

  HomeData({
    this.categories,
    this.lastAddServices,
  });

  factory HomeData.fromJson(Map<String, dynamic> json) => HomeData(
    categories: json["categories"] == null ? [] : List<Category>.from(json["categories"]!.map((x) => Category.fromJson(x))),
    lastAddServices: json["last_add_services"] == null ? [] : List<LastAddService>.from(json["last_add_services"]!.map((x) => LastAddService.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x.toJson())),
    "last_add_services": lastAddServices == null ? [] : List<dynamic>.from(lastAddServices!.map((x) => x.toJson())),
  };
}

class Category {
  final int? id;
  final String? name;
  final String? image;

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

class LastAddService {
  final String? name;
  final int? categoryId;
  final String? logo;

  LastAddService({
    this.name,
    this.categoryId,
    this.logo,
  });

  factory LastAddService.fromJson(Map<String, dynamic> json) => LastAddService(
    name: json["name"],
    categoryId: json["category_id"],
    logo: json["logo"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "category_id": categoryId,
    "logo": logo,
  };
}
