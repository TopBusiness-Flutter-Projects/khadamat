// To parse this JSON data, do
//
//     final addToFavouriteResponseModel = addToFavouriteResponseModelFromJson(jsonString);

import 'dart:convert';

AddToFavouriteResponseModel addToFavouriteResponseModelFromJson(String str) => AddToFavouriteResponseModel.fromJson(json.decode(str));

String addToFavouriteResponseModelToJson(AddToFavouriteResponseModel data) => json.encode(data.toJson());

class AddToFavouriteResponseModel {
  Data? data;
  String? message;
  int? code;

  AddToFavouriteResponseModel({
    this.data,
    this.message,
    this.code,
  });

  factory AddToFavouriteResponseModel.fromJson(Map<String, dynamic> json) => AddToFavouriteResponseModel(
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
  String? serviceId;
  int? userId;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  Data({
    this.serviceId,
    this.userId,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    serviceId: json["service_id"],
    userId: json["user_id"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "service_id": serviceId,
    "user_id": userId,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "id": id,
  };
}
