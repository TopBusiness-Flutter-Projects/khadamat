import 'package:image_picker/image_picker.dart';

class ServiceModel {
  String name;
  String category_id;
  String? sub_category_id;
  List<String> phones;
  String details;
  XFile logo;
  String? location;
  List<XFile?> images;

  @override
  String toString() {
    return 'ServiceModel{name: $name, category_id: $category_id, sub_category_id: $sub_category_id, phones: $phones, details: $details, logo: $logo, location: $location, images: $images}';
  }

  ServiceModel(
      {required this.name,
      required this.category_id,
      this.sub_category_id,
      required this.phones,
      required this.details,
      required this.logo,
      this.location,
      required this.images});
  //
  // factory ServiceModel.fromJson(Map<String, dynamic> json) {
  //   return ServiceModel(
  //     name: json["name"],
  //     category_id: json["category_id"],
  //     sub_category_id: json["sub_category_id"],
  //     phones: List.of(json["phones"]).map((i) => json["phones"]).toList(),
  //     details: json["details"],
  //     logo: XFile.fromJson(json["logo"]),
  //     location: json["location"],
  //     images: List.of(json["images"])
  //         .map((i) => i /* can't generate it properly yet */)
  //         .toList(),
  //   );
  // }
//
}
