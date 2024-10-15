// To parse this JSON data, do
//
//     final clientModelTest = clientModelTestFromJson(jsonString);

import 'dart:convert';

class ProfileModel {
    int? id;
    String? username;
    String? phoneNumber;
    String? qrCode;
    String? cashbackBalance;

    ProfileModel({
        this.id,
        this.username,
        this.phoneNumber,
        this.qrCode,
        this.cashbackBalance,
    });

    factory ProfileModel.fromRawJson(String str) => ProfileModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        id: json["id"],
        username: json["username"],
        phoneNumber: json["phone_number"],
        qrCode: json["qr_code"],
        cashbackBalance: json["cashback_balance"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "phone_number": phoneNumber,
        "qr_code": qrCode,
        "cashback_balance": cashbackBalance,
    };
}
