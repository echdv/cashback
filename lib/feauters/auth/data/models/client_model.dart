import 'dart:convert';

class ClientModel {
  int? id;
  String? username;
  String? phoneNumber;
  String? qrCode;
  String? cashbackBalance;
  String? response;
  String? token;

  ClientModel({
    this.id,
    this.username,
    this.phoneNumber,
    this.qrCode,
    this.cashbackBalance,
    this.response,
    this.token,
  });

  factory ClientModel.fromRawJson(String str) =>
      ClientModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ClientModel.fromJson(Map<String, dynamic> json) => ClientModel(
        id: json["id"],
        username: json["username"],
        phoneNumber: json["phone_number"],
        qrCode: json["qr_code"],
        cashbackBalance: json["cashback_balance"],
        response: json["response"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "phone_number": phoneNumber,
        "qr_code": qrCode,
        "cashback_balance": cashbackBalance,
        "response": response,
        "token": token,
      };
}
