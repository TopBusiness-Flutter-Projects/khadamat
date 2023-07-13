import 'dart:convert';

import 'package:image_picker/image_picker.dart';

class ServiceToUpdate{
  String? name;
  XFile? logo;
  List? phones;
  String? details;
  String? location;
  List? images;
  int? categoryId;
  String? subCategoryId;
  String? city;
  int? cityId;
  double? longitude;
  double? latitude;

  ServiceToUpdate(
      {this.name,
      this.logo,
      this.phones,
      this.details,
        this.cityId,
        this.longitude,
        this.latitude,
      this.location,
        this.city,
        this.categoryId,
        this.subCategoryId,
      this.images});

  @override
  String toString() {
    return 'ServiceToUpdate{name: $name, logo: $logo, phones: $phones, details: $details, location: $location, images: $images, categoryId: $categoryId, subCategoryId: $subCategoryId , city : $city}';
  }

factory ServiceToUpdate.fromJson(Map<String, dynamic> json) {
    return ServiceToUpdate(
      name: json["name"],
      logo: json["logo"],
      city: json["city_name"],
      cityId: json["city_id"],
      longitude: json["longitude"],
      latitude: json["latitude"],
      phones: List.of(json["phones"])
          .map((i) => i /* can't generate it properly yet */)
          .toList(),
      details: json["details"],
      location: json["location"],
      images: List.of(json["images"])
          .map((i) => i /* can't generate it properly yet */)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": this.name,
      "logo": this.logo,
      "city_id":this.cityId,
      "phones": jsonEncode(this.phones),
      "details": this.details,
      "location": this.location,
      "city_name":this.city,
      "images": jsonEncode(this.images),
      "longitude":this.longitude,
      "latitude":this.latitude,
    };
  }


}