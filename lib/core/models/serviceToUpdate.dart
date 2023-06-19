import 'dart:convert';

class ServiceToUpdate{
  String? name;
  String? logo;
  List? phones;
  String? details;
  String? location;
  List? images;
  String? categoryId;
  String? subCategoryId;

  ServiceToUpdate(
      {this.name,
      this.logo,
      this.phones,
      this.details,
      this.location,
        this.categoryId,
        this.subCategoryId,
      this.images});

  // factory ServiceToUpdate.fromJson(Map<String, dynamic> json) {
  //   return ServiceToUpdate(
  //     name: json["name"],
  //     logo: json["logo"],
  //     phones: List.of(json["phones"])
  //         .map((i) => i /* can't generate it properly yet */)
  //         .toList(),
  //     details: json["details"],
  //     location: json["location"],
  //     images: List.of(json["images"])
  //         .map((i) => i /* can't generate it properly yet */)
  //         .toList(),
  //   );
  // }
  //
  // Map<String, dynamic> toJson() {
  //   return {
  //     "name": this.name,
  //     "logo": this.logo,
  //     "phones": jsonEncode(this.phones),
  //     "details": this.details,
  //     "location": this.location,
  //     "images": jsonEncode(this.images),
  //   };
  // }

//
}