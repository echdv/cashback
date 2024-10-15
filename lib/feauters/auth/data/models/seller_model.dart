import 'dart:convert';

class SellerModel {
    int? id;
    String? username;
    String? phoneNumber;
    int? branch;

    SellerModel({
        this.id,
        this.username,
        this.phoneNumber,
        this.branch,
    });

    factory SellerModel.fromRawJson(String str) => SellerModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory SellerModel.fromJson(Map<String, dynamic> json) => SellerModel(
        id: json["id"],
        username: json["username"],
        phoneNumber: json["phone_number"],
        branch: json["branch"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "phone_number": phoneNumber,
        "branch": branch,
    };
}