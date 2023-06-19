// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
  List<NotificationDatum>? data;
  String? message;
  int? code;

  NotificationModel({
    this.data,
    this.message,
    this.code,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    data: json["data"] == null ? [] : List<NotificationDatum>.from(json["data"]!.map((x) => NotificationDatum.fromJson(x))),
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
    "code": code,
  };
}

class NotificationDatum {
  int? id;
  String? title;
  String? body;
  int? serviceId;
  int? userId;
  dynamic image;
  DateTime? createdAt;
  DateTime? updatedAt;

  NotificationDatum({
    this.id,
    this.title,
    this.body,
    this.serviceId,
    this.userId,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  factory NotificationDatum.fromJson(Map<String, dynamic> json) => NotificationDatum(
    id: json["id"],
    title: json["title"],
    body: json["body"],
    serviceId: json["service_id"],
    userId: json["user_id"],
    image: json["image"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "body": body,
    "service_id": serviceId,
    "user_id": userId,
    "image": image,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
