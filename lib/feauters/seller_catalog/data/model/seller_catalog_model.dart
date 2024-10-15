// To parse this JSON data, do
//
//     final SellerCategoryModel = SellerCategoryModelFromJson(jsonString);

import 'dart:convert';

class SellerCategoryModel {
    int? id;
    List<ListSellerCategory>? listCategories;
    String? name;
    String? address;
    bool? isActive;

    SellerCategoryModel({
        this.id,
        this.listCategories,
        this.name,
        this.address,
        this.isActive,
    });

    factory SellerCategoryModel.fromRawJson(String str) => SellerCategoryModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory SellerCategoryModel.fromJson(Map<String, dynamic> json) => SellerCategoryModel(
        id: json["id"],
        listCategories: json["list_categories"] == null ? [] : List<ListSellerCategory>.from(json["list_categories"]!.map((x) => ListSellerCategory.fromJson(x))),
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

class ListSellerCategory {
    int? id;
    String? name;

    ListSellerCategory({
        this.id,
        this.name,
    });

    factory ListSellerCategory.fromRawJson(String str) => ListSellerCategory.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ListSellerCategory.fromJson(Map<String, dynamic> json) => ListSellerCategory(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
