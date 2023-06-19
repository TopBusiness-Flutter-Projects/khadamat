// To parse this JSON data, do
//
//     final rateResponseModel = rateResponseModelFromJson(jsonString);

import 'dart:convert';

RateResponseModel rateResponseModelFromJson(String str) => RateResponseModel.fromJson(json.decode(str));

String rateResponseModelToJson(RateResponseModel data) => json.encode(data.toJson());

class RateResponseModel {
  Data? data;
  String? message;
  int? code;

  RateResponseModel({
    this.data,
    this.message,
    this.code,
  });

  factory RateResponseModel.fromJson(Map<String, dynamic> json) => RateResponseModel(
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
  num? value;
  dynamic comment;
  int? userId;
  int? serviceId;
  DateTime? createdAt;
  DateTime? updatedAt;

  Data({
    this.id,
    this.value,
    this.comment,
    this.userId,
    this.serviceId,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    value: json["value"],
    comment: json["comment"],
    userId: json["user_id"],
    serviceId: json["service_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "value": value,
    "comment": comment,
    "user_id": userId,
    "service_id": serviceId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
