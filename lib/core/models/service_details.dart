// To parse this JSON data, do
//
//     final serviceDetails = serviceDetailsFromJson(jsonString);

import 'dart:convert';

ServiceDetails serviceDetailsFromJson(String str) => ServiceDetails.fromJson(json.decode(str));

String serviceDetailsToJson(ServiceDetails data) => json.encode(data.toJson());

class ServiceDetails {
  final Data? data;
  final String? message;
  final int? code;

  ServiceDetails({
    this.data,
    this.message,
    this.code,
  });

  factory ServiceDetails.fromJson(Map<String, dynamic> json) => ServiceDetails(
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
  final int? id;
  final int? userId;
  final int? cityId;
  final int? categoryId;
  final dynamic subCategoryId;
  final String? name;
  final String? location;
  final String? longitude;
  final String? latitude;
  final List<String>? phones;
  final String? details;
  final String? logo;
  final List<String>? images;
  final int? numberOfDays;
  final DateTime? expiredAt;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Data({
    this.id,
    this.userId,
    this.cityId,
    this.categoryId,
    this.subCategoryId,
    this.name,
    this.location,
    this.longitude,
    this.latitude,
    this.phones,
    this.details,
    this.logo,
    this.images,
    this.numberOfDays,
    this.expiredAt,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    userId: json["user_id"],
    cityId: json["city_id"],
    categoryId: json["category_id"],
    subCategoryId: json["sub_category_id"],
    name: json["name"],
    location: json["location"],
    longitude: json["longitude"],
    latitude: json["latitude"],
    phones: json["phones"] == null ? [] : List<String>.from(json["phones"]!.map((x) => x)),
    details: json["details"],
    logo: json["logo"],
    images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
    numberOfDays: json["number_of_days"],
    expiredAt: json["expired_at"] == null ? null : DateTime.parse(json["expired_at"]),
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "city_id": cityId,
    "category_id": categoryId,
    "sub_category_id": subCategoryId,
    "name": name,
    "location": location,
    "longitude": longitude,
    "latitude": latitude,
    "phones": phones == null ? [] : List<dynamic>.from(phones!.map((x) => x)),
    "details": details,
    "logo": logo,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "number_of_days": numberOfDays,
    "expired_at": "${expiredAt!.year.toString().padLeft(4, '0')}-${expiredAt!.month.toString().padLeft(2, '0')}-${expiredAt!.day.toString().padLeft(2, '0')}",
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
