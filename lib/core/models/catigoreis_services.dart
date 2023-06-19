// To parse this JSON data, do
//
//     final categoriesServicesModel = categoriesServicesModelFromJson(jsonString);

import 'dart:convert';

import 'package:khadamat/core/models/servicemodel.dart';

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


