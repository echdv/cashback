// To parse this JSON data, do
//
//     final branchModel = branchModelFromJson(jsonString);

import 'dart:convert';

class BranchModel {
    int? id;
    List<ListCategory>? listCategories;
    String? name;
    String? address;
    bool? isActive;

    BranchModel({
        this.id,
        this.listCategories,
        this.name,
        this.address,
        this.isActive,
    });

    factory BranchModel.fromRawJson(String str) => BranchModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory BranchModel.fromJson(Map<String, dynamic> json) => BranchModel(
        id: json["id"],
        listCategories: json["list_categories"] == null ? [] : List<ListCategory>.from(json["list_categories"]!.map((x) => ListCategory.fromJson(x))),
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

class ListCategory {
    int? id;
    String? name;

    ListCategory({
        this.id,
        this.name,
    });

    factory ListCategory.fromRawJson(String str) => ListCategory.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ListCategory.fromJson(Map<String, dynamic> json) => ListCategory(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
