// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  String? refresh;
  String? access;
  bool? verified;

  LoginModel({
    this.refresh,
    this.access,
    this.verified
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        refresh: json["refresh"],
        access: json["access"],
        verified: json["verified"],
      );

  Map<String, dynamic> toJson() => {
        "refresh": refresh,
        "access": access,
        "verified":verified
      };
}
