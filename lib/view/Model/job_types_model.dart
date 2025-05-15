// To parse this JSON data, do
//
//     final jobTypesModel = jobTypesModelFromJson(jsonString);

import 'dart:convert';

JobTypesModel jobTypesModelFromJson(String str) => JobTypesModel.fromJson(json.decode(str));

String jobTypesModelToJson(JobTypesModel data) => json.encode(data.toJson());

class JobTypesModel {
    int? status;
    List<AllJobTypes>? data;

    JobTypesModel({
        this.status,
        this.data,
    });

    factory JobTypesModel.fromJson(Map<String, dynamic> json) => JobTypesModel(
        status: json["status"],
        data: json["data"] == null ? [] : List<AllJobTypes>.from(json["data"]!.map((x) => AllJobTypes.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class AllJobTypes {
    String? id;
    String? title;

    AllJobTypes({
        this.id,
        this.title,
    });

    factory AllJobTypes.fromJson(Map<String, dynamic> json) => AllJobTypes(
        id: json["id"],
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
    };
}
