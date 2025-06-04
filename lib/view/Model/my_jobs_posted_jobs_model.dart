// To parse this JSON data, do
//
//     final postedJobsModel = postedJobsModelFromJson(jsonString);

import 'dart:convert';

MyJobsPostedJobsModel myJobsPostedJobsModelFromJson(String str) =>
    MyJobsPostedJobsModel.fromJson(json.decode(str));

String myJobsPostedJobsModelToJson(MyJobsPostedJobsModel data) =>
    json.encode(data.toJson());

class MyJobsPostedJobsModel {
  int? status;
  List<MyJobsPostedItem>? data;

  MyJobsPostedJobsModel({
    this.status,
    this.data,
  });

  factory MyJobsPostedJobsModel.fromJson(Map<String, dynamic> json) => MyJobsPostedJobsModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<MyJobsPostedItem>.from(json["data"].map((x) => MyJobsPostedItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class MyJobsPostedItem {
  String? id;
  String? title;
  JobCategory? jobCategory;
  String? salaryFrom;
  String? salaryTo;
  DateTime? jobDate;
  DateTime? jobCreated;
  JobType? jobType;
  String? manualLocation;

  MyJobsPostedItem({
    this.id,
    this.title,
    this.jobCategory,
    this.salaryFrom,
    this.salaryTo,
    this.jobDate,
    this.jobCreated,
    this.jobType,
    this.manualLocation,
  });

  factory MyJobsPostedItem.fromJson(Map<String, dynamic> json) => MyJobsPostedItem(
        id: json["id"],
        title: json["title"],
        jobCategory: json["job_category"] == null
            ? null
            : JobCategory.fromJson(json["job_category"]),
        salaryFrom: json["salary_from"],
        salaryTo: json["salary_to"],
        jobDate:
            json["job_date"] == null ? null : DateTime.parse(json["job_date"]),
        jobCreated: json["job_created"] == null
            ? null
            : DateTime.parse(json["job_created"]),
        jobType: json["job_type"] == null
            ? null
            : JobType.fromJson(json["job_type"]),
        manualLocation: json["manual_location"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "job_category": jobCategory?.toJson(),
        "salary_from": salaryFrom,
        "salary_to": salaryTo,
        "job_date": jobDate?.toIso8601String().split("T").first,
        "job_created": jobCreated?.toIso8601String(),
        "job_type": jobType?.toJson(),
        "manual_location": manualLocation,
      };
}

class JobCategory {
  String? id;
  String? title;

  JobCategory({
    this.id,
    this.title,
  });

  factory JobCategory.fromJson(Map<String, dynamic> json) => JobCategory(
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
      };
}

class JobType {
  String? id;
  String? title;

  JobType({
    this.id,
    this.title,
  });

  factory JobType.fromJson(Map<String, dynamic> json) => JobType(
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
      };
}
