// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<Productss> welcomeFromJson(String str) =>
    List<Productss>.from(json.decode(str).map((x) => Productss.fromJson(x)));

String welcomeToJson(List<Productss> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Productss {
  Productss({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.images,
    this.categoryId,
  });

  int? id;
  String? title;
  int? price;
  String? description;
  Category? category;
  List<String>? images;
  int? categoryId;

  factory Productss.fromJson(Map<String, dynamic> json) => Productss(
        id: json["id"],
        title: json["title"],
        price: json["price"],
        description: json["description"],
        category: Category.fromJson(json["category"]),
        images: List<String>.from(json["images"].map((x) => x)),
        categoryId: json["categoryId"] == null ? null : json["categoryId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "description": description,
        "category": category!.toJson(),
        "images": List<dynamic>.from(images!.map((x) => x)),
        "categoryId": categoryId == null ? null : categoryId,
      };
}

class Category {
  Category({
    this.id,
    this.name,
    this.image,
    this.keyLoremSpace,
  });

  int? id;
  Name? name;
  String? image;
  String? keyLoremSpace;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: nameValues.map[json["name"]],
        image: json["image"],
        keyLoremSpace:
            json["keyLoremSpace"] == null ? null : json["keyLoremSpace"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": nameValues.reverse[name],
        "image": image,
        "keyLoremSpace": keyLoremSpace == null ? null : keyLoremSpace,
      };
}

enum Name { FURNITURE, SHOES, CLOTHES, OTHERS, ELECTRONICS }

final nameValues = EnumValues({
  "Clothes": Name.CLOTHES,
  "Electronics": Name.ELECTRONICS,
  "Furniture": Name.FURNITURE,
  "Others": Name.OTHERS,
  "Shoes": Name.SHOES
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
