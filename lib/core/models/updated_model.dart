// To parse this JSON data, do
//
//     final updatedModel = updatedModelFromJson(jsonString);

import 'dart:convert';

import 'package:khadamat/core/models/servicemodel.dart';

UpdatedModel updatedModelFromJson(String str) => UpdatedModel.fromJson(json.decode(str));

String updatedModelToJson(UpdatedModel data) => json.encode(data.toJson());

class UpdatedModel {
  ServicesModel? data;
  String? message;
  int? code;

  UpdatedModel({
    this.data,
    this.message,
    this.code,
  });

  factory UpdatedModel.fromJson(Map<String, dynamic> json) => UpdatedModel(
    data: json["data"] == null ? null : ServicesModel.fromJson(json["data"]),
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "message": message,
    "code": code,
  };
}

