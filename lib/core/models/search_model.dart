// To parse this JSON data, do
//
//     final searchModel = searchModelFromJson(jsonString);

import 'dart:convert';

SearchModel searchModelFromJson(String str) => SearchModel.fromJson(json.decode(str));

String searchModelToJson(SearchModel data) => json.encode(data.toJson());

class SearchModel {
  List<Datum>? data;
  String? message;
  int? code;

  SearchModel({
    this.data,
    this.message,
    this.code,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
    "code": code,
  };
}

class Datum {
  int? id;
  dynamic name;
  dynamic price;
  dynamic priceAfterDiscount;
  dynamic image;

  Datum({
    this.id,
    this.name,
    this.price,
    this.priceAfterDiscount,
    this.image,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    priceAfterDiscount: json["price_after_discount"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "price_after_discount": priceAfterDiscount,
    "image": image,
  };
}
