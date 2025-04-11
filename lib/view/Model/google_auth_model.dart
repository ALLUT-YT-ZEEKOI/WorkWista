// To parse this JSON data, do
//
//     final googleAuthModel = googleAuthModelFromJson(jsonString);

import 'dart:convert';

GoogleAuthModel googleAuthModelFromJson(String str) => GoogleAuthModel.fromJson(json.decode(str));

String googleAuthModelToJson(GoogleAuthModel data) => json.encode(data.toJson());

class GoogleAuthModel {
    String? message;
    User? user;
    String? accessToken;
    String? refreshToken;

    GoogleAuthModel({
        this.message,
        this.user,
        this.accessToken,
        this.refreshToken,
    });

    factory GoogleAuthModel.fromJson(Map<String, dynamic> json) => GoogleAuthModel(
        message: json["message"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        accessToken: json["access_token"],
        refreshToken: json["refresh_token"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "user": user?.toJson(),
        "access_token": accessToken,
        "refresh_token": refreshToken,
    };
}

class User {
    String? id;
    String? email;
    String? name;
    String? profilePictureGoogle;

    User({
        this.id,
        this.email,
        this.name,
        this.profilePictureGoogle,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        name: json["name"],
        profilePictureGoogle: json["profile_picture_google"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "name": name,
        "profile_picture_google": profilePictureGoogle,
    };
}
