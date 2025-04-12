// To parse this JSON data, do
//
//     final addJobModel = addJobModelFromJson(jsonString);

import 'dart:convert';

AddJobModel addJobModelFromJson(String str) => AddJobModel.fromJson(json.decode(str));

String addJobModelToJson(AddJobModel data) => json.encode(data.toJson());

class AddJobModel {
    String? status;
    String? message;

    AddJobModel({
        this.status,
        this.message,
    });

    factory AddJobModel.fromJson(Map<String, dynamic> json) => AddJobModel(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
    };
}
