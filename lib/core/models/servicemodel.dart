class ServicesModel {
  int? id;
  String? name;
  String? logo;
  var phones;
  String? details;
  String? category;
  String? subCategory;
  int? rate;
  int? following;
  int? followers;
  int? reviews;
  List<String>? images;
  Provider? provider;

  @override
  String toString() {
    return 'ServicesModel{id: $id, name: $name, logo: $logo, phones: $phones, details: $details, category: $category, subCategory: $subCategory, rate: $rate, following: $following, followers: $followers, reviews: $reviews, images: $images, provider: $provider}';
  }

  ServicesModel({
    this.id,
    this.name,
    this.logo,
    this.phones,
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

  factory ServicesModel.fromJson(Map<String, dynamic> json) => ServicesModel(
    id: json["id"],
    name: json["name"],
    logo: json["logo"],
    phones: json["phones"],
        //== null ? [] : List<String>.from(json["phones"]!.map((x) => x)),
    details: json["details"],
    category: json["category"],
    subCategory: json["sub_category"],
    rate: json["rate"],
    following: json["following"],
    followers: json["followers"],
    reviews: json["reviews"],
    images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
    provider: json["provider"] == null ? null : Provider.fromJson(json["provider"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "logo": logo,
    "phones": phones == null ? [] : List<dynamic>.from(phones!.map((x) => x)),
    "details": details,
    "category": category,
    "sub_category": subCategory,
    "rate": rate,
    "following": following,
    "followers": followers,
    "reviews": reviews,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "provider": provider?.toJson(),
  };
}
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
