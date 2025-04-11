// To parse this JSON data, do
//
//     final userProfileModel = userProfileModelFromJson(jsonString);

import 'dart:convert';

UserProfileModel userProfileModelFromJson(String str) => UserProfileModel.fromJson(json.decode(str));


class UserProfileModel {
    String? status;
    Data? data;

    UserProfileModel({
        this.status,
        this.data,
    });

    factory UserProfileModel.fromJson(Map<String, dynamic> json) => UserProfileModel(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
    };
}

class Data {
    String? id;
    String? email;
    String? phoneNumber;
    String? name;
    DateTime? dob;

    Data({
        this.id,
        this.email,
        this.phoneNumber,
        this.name,
        this.dob,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        name: json["name"],
        dob: json["DOB"] == null ? null : DateTime.parse(json["DOB"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "phone_number": phoneNumber,
        "name": name,
        "DOB": "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
    };
}
