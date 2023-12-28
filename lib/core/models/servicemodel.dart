class ServicesModel {
  int? id;
  String? name;
  String? logo;
  var phones;
  String? location;
  String? longitude;
  String? latitude;
  dynamic cityId;
  String? cityName;
  String? details;
  String? category;
  String? subCategory;
  var rate;
  int? following;
  int? followers;
  int? reviews;
  List<String>? images;
  Provider? provider;

  ServicesModel({
    this.id,
    this.name,
    this.logo,
    this.phones,
    this.location,
    this.longitude,
    this.latitude,
    this.cityId,
    this.cityName,
    this.details,
    this.category,
    this.subCategory,
    this.rate,
    this.following,
    this.followers,
    this.reviews,
    this.images,
    this.provider,
  });

  @override
  String toString() {
    return 'ServicesModel{id: $id, name: $name, logo: $logo, phones: $phones, location: $location, longitude: $longitude, latitude: $latitude, cityId: $cityId, details: $details, category: $category, subCategory: $subCategory, rate: $rate, following: $following, followers: $followers, reviews: $reviews, images: $images, provider: $provider}';
  }

  factory ServicesModel.fromJson(Map<String, dynamic> json) => ServicesModel(
        id: json["id"],
        name: json["name"],
        logo: json["logo"],
        phones: json["phones"],
        cityName: json["city_name"],
        // phones: json["phones"] == null|| json["phones"] is! String
        //     ? [] // Return an empty list if "phones" is null or not a string
        //     : json["phones"].split(",").map((phone) => phone.trim()).toList(), // Split "phones" into a List<String>
        // phones: json["phones"] == null || json["phones"] == '' ? [] :
        //List<String>.from(json["phones"]!.map((x) => x)),
        location: json["location"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        cityId: json["city_id"],
        details: json["details"],
        category: json["category"],
        subCategory: json["sub_category"],
        rate: json["rate"],
        following: json["following"],
        followers: json["followers"],
        reviews: json["reviews"],
        images: json["images"] == null
            ? []
            : List<String>.from(json["images"]!.map((x) => x)),
        provider: json["provider"] == null
            ? null
            : Provider.fromJson(json["provider"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "logo": logo,
        "phones":
            phones == null ? [] : List<dynamic>.from(phones!.map((x) => x)),
        "location": location,
        "longitude": longitude,
        "latitude": latitude,
        "city_id": cityId,
        "city_name": cityName,
        "details": details,
        "category": category,
        "sub_category": subCategory,
        "rate": rate,
        "following": following,
        "followers": followers,
        "reviews": reviews,
        "images":
            images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "provider": provider?.toJson(),
      };
}

// class Provider {
//   int? id;
//   String? name;
//   dynamic phoneCode;
//   String? phone;
//   Provider({
//     this.id,
//     this.name,
//     this.phoneCode,
//     this.phone,
//   });
//
//   factory Provider.fromJson(Map<String, dynamic> json) => Provider(
//     id: json["id"],
//     name: json["name"],
//     phoneCode: json["phone_code"],
//     phone: json["phone"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "phone_code": phoneCode,
//     "phone": phone,
//   };
// }

class Provider {
  int? id;
  dynamic name;
  dynamic phoneCode;
  String? phone;

  Provider({
    this.id,
    this.name,
    this.phoneCode,
    this.phone,
  });

  factory Provider.fromJson(Map<String, dynamic> json) => Provider(
        id: json["id"],
        name: json["name"],
        phoneCode: json["phone_code"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone_code": phoneCode,
        "phone": phone,
      };
}
