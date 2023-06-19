// To parse this JSON data, do
//
//     final myServicesModel = myServicesModelFromJson(jsonString);

import 'dart:convert';

import 'package:khadamat/core/models/servicemodel.dart';

MyServicesModel myServicesModelFromJson(String str) => MyServicesModel.fromJson(json.decode(str));

String myServicesModelToJson(MyServicesModel data) => json.encode(data.toJson());

class MyServicesModel {
  List<ServicesModel>? data;
  String? message;
  int? code;

  MyServicesModel({
    this.data,
    this.message,
    this.code,
  });

  factory MyServicesModel.fromJson(Map<String, dynamic> json) => MyServicesModel(
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






class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
