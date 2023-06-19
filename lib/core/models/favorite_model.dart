// To parse this JSON data, do
//
//     final favoriteModel = favoriteModelFromJson(jsonString);

import 'dart:convert';

import 'package:khadamat/core/models/catigoreis_services.dart';
import 'package:khadamat/core/models/servicemodel.dart';

FavoriteModel favoriteModelFromJson(String str) => FavoriteModel.fromJson(json.decode(str));

String favoriteModelToJson(FavoriteModel data) => json.encode(data.toJson());

class FavoriteModel {
  final List<FavoriteModelDatum>? data;
  final String? message;
  final int? code;

  @override
  String toString() {
    return 'FavoriteModel{data: $data, message: $message, code: $code}';
  }

  FavoriteModel({
    this.data,
    this.message,
    this.code,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) => FavoriteModel(
    data: json["data"] == null ? [] : List<FavoriteModelDatum>.from(json["data"]!.map((x) => FavoriteModelDatum.fromJson(x))),
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
    "code": code,
  };
}

class FavoriteModelDatum {
  final int? id;
  final int? userId;
  final int? serviceId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final ServicesModel? service;

  @override
  String toString() {
    return 'FavoriteModelDatum{id: $id, userId: $userId, serviceId: $serviceId, createdAt: $createdAt, updatedAt: $updatedAt, service: $service}';
  }

  FavoriteModelDatum({
    this.id,
    this.userId,
    this.serviceId,
    this.createdAt,
    this.updatedAt,
    this.service,
  });

  factory FavoriteModelDatum.fromJson(Map<String, dynamic> json) => FavoriteModelDatum(
    id: json["id"],
    userId: json["user_id"],
    serviceId: json["service_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    service: json["service"] == null ? null : ServicesModel.fromJson(json["service"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "service_id": serviceId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "service": service?.toJson(),
  };
}