// To parse this JSON data, do
//
//     final clientModelTest = clientModelTestFromJson(jsonString);

import 'dart:convert';

class ClientModelTest {
    int? id;
    String? username;
    String? phoneNumber;
    String? qrCode;
    String? cashbackBalance;

    ClientModelTest({
        this.id,
        this.username,
        this.phoneNumber,
        this.qrCode,
        this.cashbackBalance,
    });

    factory ClientModelTest.fromRawJson(String str) => ClientModelTest.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ClientModelTest.fromJson(Map<String, dynamic> json) => ClientModelTest(
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
