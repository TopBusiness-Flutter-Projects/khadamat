class SliderModel {
  SliderModel({
    this.id,
    this.file,
    this.type,
    this.link,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final String? file;
  final String? type;
  final String? link;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory SliderModel.fromJson(Map<String, dynamic> json) => SliderModel(
    id: json["id"],
    file: json["file"],
    type: json["type"],
    link: json["link"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "file": file,
    "type": type,
    "link": link,
    "created_at":
    "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
    "updated_at":
    "${updatedAt!.year.toString().padLeft(4, '0')}-${updatedAt!.month.toString().padLeft(2, '0')}-${updatedAt!.day.toString().padLeft(2, '0')}",
  };
}
