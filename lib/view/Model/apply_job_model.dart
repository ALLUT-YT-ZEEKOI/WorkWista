// To parse this JSON data, do
//
//     final applyJobModel = applyJobModelFromJson(jsonString);

import 'dart:convert';

ApplyJobModel applyJobModelFromJson(String str) => ApplyJobModel.fromJson(json.decode(str));

String applyJobModelToJson(ApplyJobModel data) => json.encode(data.toJson());

class ApplyJobModel {
    String? message;
    Data? data;

    ApplyJobModel({
        this.message,
        this.data,
    });

    factory ApplyJobModel.fromJson(Map<String, dynamic> json) => ApplyJobModel(
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
    };
}

class Data {
    String? id;
    String? job;
    String? applicant;
    DateTime? requesteDate;
    bool? isAccepted;

    Data({
        this.id,
        this.job,
        this.applicant,
        this.requesteDate,
        this.isAccepted,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        job: json["job"],
        applicant: json["applicant"],
        requesteDate: json["requeste_date"] == null ? null : DateTime.parse(json["requeste_date"]),
        isAccepted: json["is_accepted"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "job": job,
        "applicant": applicant,
        "requeste_date": requesteDate?.toIso8601String(),
        "is_accepted": isAccepted,
    };
}
