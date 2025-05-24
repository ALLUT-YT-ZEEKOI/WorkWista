// To parse this JSON data, do
//
//     final jobDetailsModel = jobDetailsModelFromJson(jsonString);

import 'dart:convert';

JobDetailsModel jobDetailsModelFromJson(String str) =>
    JobDetailsModel.fromJson(json.decode(str));

class JobDetailsModel {
  int? status;
  Data? data;

  JobDetailsModel({
    this.status,
    this.data,
  });

  factory JobDetailsModel.fromJson(Map<String, dynamic> json) =>
      JobDetailsModel(
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
  String? title;
  String? description;
  String? key_responsibility;
  String? jobImage;
  String? jobType;
  String? jobCategory;
  String? salary_from;
  String? salary_to;
  DateTime? jobDate;
  DateTime? jobCreated;
  String? recruter;

  Data({
    this.id,
    this.title,
    this.description,
    this.jobImage,
    this.jobType,
    this.jobCategory,
    this.salary_from,
    this.salary_to,
    this.key_responsibility,
    this.jobDate,
    this.jobCreated,
    this.recruter,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        jobImage: json["job_image"],
        jobType: json["job_type"],
        jobCategory: json["job_category"],
        salary_from: json["salary_from"],
        salary_to: json["salary_to"],
        key_responsibility: json["key_responsibility"],
        jobDate:
            json["job_date"] == null ? null : DateTime.parse(json["job_date"]),
        jobCreated: json["job_created"] == null
            ? null
            : DateTime.parse(json["job_created"]),
        recruter: json["recruter"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "job_image": jobImage,
        "job_type": jobType,
        "job_category": jobCategory,
        "salary_from": salary_from,
        "salary_to": salary_to,
        "key_responsibility": key_responsibility,
        "job_date":
            "${jobDate!.year.toString().padLeft(4, '0')}-${jobDate!.month.toString().padLeft(2, '0')}-${jobDate!.day.toString().padLeft(2, '0')}",
        "job_created": jobCreated?.toIso8601String(),
        "recruter": recruter,
      };
}
