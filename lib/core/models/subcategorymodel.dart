class SubCategoryMainModel {
  List<SubCategoryModeel>? data;
  String? message;
  int? code;

  SubCategoryMainModel({
    this.data,
    this.message,
    this.code,
  });

  factory SubCategoryMainModel.fromJson(Map<String, dynamic> json) =>
      SubCategoryMainModel(
        data: json["data"] == null
            ? []
            : List<SubCategoryModeel>.from(
                json["data"]!.map((x) => SubCategoryModeel.fromJson(x))),
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

class SubCategoryModeel {
  int? id;
  String? name;
  int? catId;
  DateTime? createdAt;
  DateTime? updatedAt;

  SubCategoryModeel({
    this.id,
    this.name,
    this.catId,
    this.createdAt,
    this.updatedAt,
  });

  factory SubCategoryModeel.fromJson(Map<String, dynamic> json) =>
      SubCategoryModeel(
        id: json["id"],
        name: json["name"],
        catId: json["cat_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "cat_id": catId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
