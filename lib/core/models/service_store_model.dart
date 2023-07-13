// To parse this JSON data, do
//
//     final serviceStoreModel = serviceStoreModelFromJson(jsonString);

import 'dart:convert';
//
// ServiceStoreModel serviceStoreModelFromJson(String str) => ServiceStoreModel.fromJson(json.decode(str));
//
// String serviceStoreModelToJson(ServiceStoreModel data) => json.encode(data.toJson());
//
// class ServiceStoreModel {
//   Data? data;
//   String? message;
//   int? code;
//
//   ServiceStoreModel({
//     this.data,
//     this.message,
//     this.code,
//   });
//
//   factory ServiceStoreModel.fromJson(Map<String, dynamic> json) => ServiceStoreModel(
//     data: json["data"] == null ? null : Data.fromJson(json["data"]),
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
// class Data {
//   int? id;
//   String? name;
//   String? logo;
//   List<String>? phones;
//   String? details;
//   String? category;
//   String? subCategory;
//   int? rate;
//   int? following;
//   int? followers;
//   int? reviews;
//   List<dynamic>? images;
//   Provider? provider;
//
//   Data({
//     this.id,
//     this.name,
//     this.logo,
//     this.phones,
//     this.details,
//     this.category,
//     this.subCategory,
//     this.rate,
//     this.following,
//     this.followers,
//     this.reviews,
//     this.images,
//     this.provider,
//   });
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//     id: json["id"],
//     name: json["name"],
//     logo: json["logo"],
//     phones: json["phones"] == null ? [] : List<String>.from(json["phones"]!.map((x) => x)),
//     details: json["details"],
//     category: json["category"],
//     subCategory: json["sub_category"],
//     rate: json["rate"],
//     following: json["following"],
//     followers: json["followers"],
//     reviews: json["reviews"],
//     images: json["images"] == null ? [] : List<dynamic>.from(json["images"]!.map((x) => x)),
//     provider: json["provider"] == null ? null : Provider.fromJson(json["provider"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "logo": logo,
//     "phones": phones == null ? [] : List<dynamic>.from(phones!.map((x) => x)),
//     "details": details,
//     "category": category,
//     "sub_category": subCategory,
//     "rate": rate,
//     "following": following,
//     "followers": followers,
//     "reviews": reviews,
//     "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
//     "provider": provider?.toJson(),
//   };
// }
//
// class Provider {
//   int? id;
//   String? name;
//   dynamic phoneCode;
//   String? phone;
//
//   Provider({
//     this.id,
//     this.name,
//     this.phoneCode,
//     this.phone,
//   });
//
//   factory Provider.fromJson(Map<String, dynamic> json) => Provider(
//     id: json["id"],
//     name: json["name"],
//     phoneCode: json["phone_code"],
//     phone: json["phone"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "phone_code": phoneCode,
//     "phone": phone,
//   };
// }

// To parse this JSON data, do
//
//     final serviceStoreModel = serviceStoreModelFromJson(jsonString);

import 'dart:convert';

ServiceStoreModel serviceStoreModelFromJson(String str) => ServiceStoreModel.fromJson(json.decode(str));

String serviceStoreModelToJson(ServiceStoreModel data) => json.encode(data.toJson());

class ServiceStoreModel {
  Data? data;
  dynamic message;
  int? code;

  ServiceStoreModel({
    this.data,
    this.message,
    this.code,
  });

  factory ServiceStoreModel.fromJson(Map<String, dynamic> json) => ServiceStoreModel(
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
  int? id;
  String? name;
  String? logo;
  List<String>? phones;
  String? location;
  String? longitude;
  String? latitude;
  String? cityId;
  String? cityName;
  String? details;
  String? category;
  String? subCategory;
  int? rate;
  int? following;
  int? followers;
  int? reviews;
  List<String>? images;
  Provider? provider;

  Data({
    this.id,
    this.name,
    this.logo,
    this.phones,
    this.location,
    this.longitude,
    this.latitude,
    this.cityId,
    this.cityName,
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    logo: json["logo"],
    phones: json["phones"] == null ? [] : List<String>.from(json["phones"]!.map((x) => x)),
    location: json["location"],
    longitude: json["longitude"],
    latitude: json["latitude"],
    cityId: json["city_id"],
    cityName: json["city_name"],
    details: json["details"],
    category: json["category"],
    subCategory: json["sub_category"],
    rate: json["rate"],
    following: json["following"],
    followers: json["followers"],
    reviews: json["reviews"],
    images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
    provider: json["provider"] == null ? null : Provider.fromJson(json["provider"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "logo": logo,
    "phones": phones == null ? [] : List<dynamic>.from(phones!.map((x) => x)),
    "location": location,
    "longitude": longitude,
    "latitude": latitude,
    "city_id": cityId,
    "city_name": cityName,
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
}

class Provider {
  int? id;
  String? name;
  String? phoneCode;
  String? phone;

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

