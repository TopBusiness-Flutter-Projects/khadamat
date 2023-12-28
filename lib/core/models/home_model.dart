import 'servicemodel.dart';

class HomeModel {
  Data? data;
  String? message;
  int? code;

  HomeModel({
    this.data,
    this.message,
    this.code,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
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
  List<Category>? categories;
  List<ServicesModel>? servicesModels;

  Data({
    this.categories,
    this.servicesModels,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        categories: json["categories"] == null
            ? []
            : List<Category>.from(
                json["categories"]!.map((x) => Category.fromJson(x))),
        servicesModels: json["last_add_services"] == null
            ? []
            : List<ServicesModel>.from(json["last_add_services"]!
                .map((x) => ServicesModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categories": categories == null
            ? []
            : List<dynamic>.from(categories!.map((x) => x.toJson())),
        "last_add_services": servicesModels == null
            ? []
            : List<dynamic>.from(servicesModels!.map((x) => x.toJson())),
      };
}

class Category {
  int? id;
  String? name;
  String? image;
  int? subsCount;

  Category({this.id, this.name, this.image, this.subsCount});

  factory Category.fromJson(Map<String, dynamic> json) => Category(
      id: json["id"],
      name: json["name"],
      image: json["image"],
      subsCount: json['subs_count']);

  Map<String, dynamic> toJson() =>
      {"id": id, "name": name, "image": image, "subs_count": subsCount};
}
