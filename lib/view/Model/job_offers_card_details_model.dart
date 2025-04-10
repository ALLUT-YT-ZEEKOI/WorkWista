// To parse this JSON data, do
//
//     final jobOfferCardDetailsModel = jobOfferCardDetailsModelFromJson(jsonString);

import 'dart:convert';

JobOfferCardDetailsModel jobOfferCardDetailsModelFromJson(String str) => JobOfferCardDetailsModel.fromJson(json.decode(str));



class JobOfferCardDetailsModel {
    int? status;
    List<JobOfferCardDetails>? data;
    int? statusCode;

    JobOfferCardDetailsModel({
        this.status,
        this.data,
        this.statusCode,
    });

    factory JobOfferCardDetailsModel.fromJson(Map<String, dynamic> json) => JobOfferCardDetailsModel(
        status: json["status"],
        data: json["data"] == null ? [] : List<JobOfferCardDetails>.from(json["data"]!.map((x) => JobOfferCardDetails.fromJson(x))),
        statusCode: json["status_code"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "status_code": statusCode,
    };
}

class JobOfferCardDetails {
    String? id;
    String? title;
    String? jobCategory;
    String? salary;
    DateTime? jobDate;
    DateTime? jobCreated;

    JobOfferCardDetails({
        this.id,
        this.title,
        this.jobCategory,
        this.salary,
        this.jobDate,
        this.jobCreated,
    });

    factory JobOfferCardDetails.fromJson(Map<String, dynamic> json) => JobOfferCardDetails(
        id: json["id"],
        title: json["title"],
        jobCategory: json["job_category"],
        salary: json["salary"],
        jobDate: json["job_date"] == null ? null : DateTime.parse(json["job_date"]),
        jobCreated: json["job_created"] == null ? null : DateTime.parse(json["job_created"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "job_category": jobCategory,
        "salary": salary,
        "job_date": "${jobDate!.year.toString().padLeft(4, '0')}-${jobDate!.month.toString().padLeft(2, '0')}-${jobDate!.day.toString().padLeft(2, '0')}",
        "job_created": jobCreated?.toIso8601String(),
    };
}
