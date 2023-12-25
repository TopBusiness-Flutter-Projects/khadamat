// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) =>
    NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) =>
    json.encode(data.toJson());

class NotificationModel {
  List<NotificationDatum>? data;
  String? message;
  int? code;

  NotificationModel({
    this.data,
    this.message,
    this.code,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        data: json["data"] == null
            ? []
            : List<NotificationDatum>.from(
                json["data"]!.map((x) => NotificationDatum.fromJson(x))),
        message: json["message"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
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
  Service? service;

  NotificationDatum({
    this.id,
    this.title,
    this.body,
    this.serviceId,
    this.userId,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.service,
  });

  factory NotificationDatum.fromJson(Map<String, dynamic> json) =>
      NotificationDatum(
        id: json["id"],
        title: json["title"],
        body: json["body"],
        serviceId: json["service_id"],
        userId: json["user_id"],
        image: json["image"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        service:
            json["service"] == null ? null : Service.fromJson(json["service"]),
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
        "service": service?.toJson(),
      };
}

class Service {
  int? id;
  String? name;
  String? logo;
  List<String?>? phones;
  String? location;
  String? longitude;
  String? latitude;
  int? cityId;
  String? cityName;
  String? details;
  String? category;
  String? subCategory;
  double? rate;
  int? following;
  int? followers;
  int? reviews;
  List<String>? images;
  Provider? provider;

  Service({
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

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json["id"],
        name: json["name"],
        logo: json["logo"],
        phones: json["phones"] == null
            ? []
            : List<String?>.from(json["phones"]!.map((x) => x)),
        location: json["location"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        cityId: json["city_id"],
        cityName: json["city_name"],
        details: json["details"],
        category: json["category"],
        subCategory: json["sub_category"],
        rate: json["rate"]?.toDouble(),
        following: json["following"],
        followers: json["followers"],
        reviews: json["reviews"],
        images: json["images"] == null
            ? []
            : List<String>.from(json["images"]!.map((x) => x)),
        provider: json["provider"] == null
            ? null
            : Provider.fromJson(json["provider"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "logo": logo,
        "phones":
            phones == null ? [] : List<dynamic>.from(phones!.map((x) => x)),
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
        "images":
            images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
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
