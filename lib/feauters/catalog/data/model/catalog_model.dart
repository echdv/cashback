// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

class CategoryModel {
    int? id;
    List<ListCategorys>? listCategories;
    String? name;
    String? address;
    bool? isActive;

    CategoryModel({
        this.id,
        this.listCategories,
        this.name,
        this.address,
        this.isActive,
    });

    factory CategoryModel.fromRawJson(String str) => CategoryModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        listCategories: json["list_categories"] == null ? [] : List<ListCategorys>.from(json["list_categories"]!.map((x) => ListCategorys.fromJson(x))),
        name: json["name"],
        address: json["address"],
        isActive: json["is_active"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "list_categories": listCategories == null ? [] : List<dynamic>.from(listCategories!.map((x) => x.toJson())),
        "name": name,
        "address": address,
        "is_active": isActive,
    };
}

class ListCategorys {
    int? id;
    String? name;

    ListCategorys({
        this.id,
        this.name,
    });

    factory ListCategorys.fromRawJson(String str) => ListCategorys.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ListCategorys.fromJson(Map<String, dynamic> json) => ListCategorys(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
