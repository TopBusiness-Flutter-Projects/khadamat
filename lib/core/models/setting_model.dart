// To parse this JSON data, do
//
//     final settingModel = settingModelFromJson(jsonString);

import 'dart:convert';

SettingModel settingModelFromJson(String str) => SettingModel.fromJson(json.decode(str));

String settingModelToJson(SettingModel data) => json.encode(data.toJson());

class SettingModel {
  Data? data;
  String? message;
  int? code;

  SettingModel({
    this.data,
    this.message,
    this.code,
  });

  factory SettingModel.fromJson(Map<String, dynamic> json) => SettingModel(
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
  String? aboutAr;
  String? aboutEn;
  String? termsAr;
  String? termsEn;
  String? privacyAr;
  String? privacyEn;
  dynamic instagram;
  dynamic whatsapp;
  dynamic createdAt;
  dynamic updatedAt;

  Data({
    this.id,
    this.aboutAr,
    this.aboutEn,
    this.termsAr,
    this.termsEn,
    this.privacyAr,
    this.privacyEn,
    this.instagram,
    this.whatsapp,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    aboutAr: json["about_ar"],
    aboutEn: json["about_en"],
    termsAr: json["terms_ar"],
    termsEn: json["terms_en"],
    privacyAr: json["privacy_ar"],
    privacyEn: json["privacy_en"],
    instagram: json["instagram"],
    whatsapp: json["whatsapp"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "about_ar": aboutAr,
    "about_en": aboutEn,
    "terms_ar": termsAr,
    "terms_en": termsEn,
    "privacy_ar": privacyAr,
    "privacy_en": privacyEn,
    "instagram": instagram,
    "whatsapp": whatsapp,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
