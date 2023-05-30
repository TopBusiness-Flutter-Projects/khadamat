// To parse this JSON data, do
//
//     final categoriesServicesModel = categoriesServicesModelFromJson(jsonString);

import 'dart:convert';

CategoriesServicesModel categoriesServicesModelFromJson(String str) => CategoriesServicesModel.fromJson(json.decode(str));

String categoriesServicesModelToJson(CategoriesServicesModel data) => json.encode(data.toJson());

class CategoriesServicesModel {
  final List<ServicesModel>? data;
  final String? message;
  final int? code;

  CategoriesServicesModel({
    this.data,
    this.message,
    this.code,
  });

  factory CategoriesServicesModel.fromJson(Map<String, dynamic> json) => CategoriesServicesModel(
    data: json["data"] == null ? [] : List<ServicesModel>.from(json["data"]!.map((x) => ServicesModel.fromJson(x))),
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
    "code": code,
  };
}

class ServicesModel {
  final int? id;
  final String? name;
  final String? logo;
  final List<String>? phones;
  final String? details;
  final String? category;
  final String? subCategory;
  final int? rate;
  final int? following;
  final int? followers;
  final int? reviews;
  final List<String>? images;
  final Provider? provider;

  ServicesModel({
    this.id,
    this.name,
    this.logo,
    this.phones,
    this.details,
    this.category,
    this.subCategory,
    this.rate,
    this.following,
    this.followers,
    this.reviews,
    this.images,
    this.provider,
  });

  factory ServicesModel.fromJson(Map<String, dynamic> json) => ServicesModel(
    id: json["id"],
    name: json["name"],
    logo: json["logo"],
    phones: json["phones"] == null ? [] : List<String>.from(json["phones"]!.map((x) => x)),
    details: json["details"],
    category: json["category"],
    subCategory: json["sub_category"],
    rate: json["rate"]??0,
    following: json["following"]??0,
    followers: json["followers"]??0,
    reviews: json["reviews"]??0,
    images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
    provider: json["provider"] == null ? null : Provider.fromJson(json["provider"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "logo": logo,
    "phones": phones == null ? [] : List<dynamic>.from(phones!.map((x) => x)),
    "details": details,
    "category": category,
    "sub_category": subCategory,
    "rate": rate,
    "following": following,
    "followers": followers,
    "reviews": reviews,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "provider": provider?.toJson(),
  };

  @override
  String toString() {
    return 'ServicesModel{id: $id, name: $name, logo: $logo, phones: $phones, details: $details, category: $category, subCategory: $subCategory, rate: $rate, following: $following, followers: $followers, reviews: $reviews, images: $images, provider: $provider}';
  }
}

class Provider {
  final int? id;
  final String? name;
  final dynamic phoneCode;
  final String? phone;

  Provider({
    this.id,
    this.name,
    this.phoneCode,
    this.phone,
  });

  factory Provider.fromJson(Map<String, dynamic> json) => Provider(
    id: json["id"],
    name: json["name"],
    phoneCode: json["phone_code"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone_code": phoneCode,
    "phone": phone,
  };
}
