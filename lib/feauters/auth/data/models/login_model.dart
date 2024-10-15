import 'dart:convert';

class LoginModel {
  int? id;
  String? token;
  bool? isStaff;

  LoginModel({
    this.id,
    this.token,
    this.isStaff,
  });

  factory LoginModel.fromRawJson(String str) =>
      LoginModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        id: json["id"],
        token: json["token"],
        isStaff: json["is_staff"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "token": token,
        "is_staff": isStaff,
      };
}
