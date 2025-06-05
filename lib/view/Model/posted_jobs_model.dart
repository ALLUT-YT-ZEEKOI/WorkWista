// To parse this JSON data, do
//
//     final postedJobsModel = postedJobsModelFromJson(jsonString);

import 'dart:convert';

PostedJobsModel postedJobsModelFromJson(String str) =>
    PostedJobsModel.fromJson(json.decode(str));

String postedJobsModelToJson(PostedJobsModel data) =>
    json.encode(data.toJson());

class PostedJobsModel {
  int? status;
  List<PostedItem>? data;

  PostedJobsModel({
    this.status,
    this.data,
  });

  factory PostedJobsModel.fromJson(Map<String, dynamic> json) =>
      PostedJobsModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<PostedItem>.from(
                json["data"]!.map((x) => PostedItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class PostedItem {
  String? id;
  int? requestsCount;
  String? title;
  String? jobCategory;
  String? salary_from;
  String? salary_to;
  DateTime? jobDate;
  DateTime? jobCreated;
  String? jobType;
  bool? is_closed_job;

  PostedItem({
    this.id,
    this.requestsCount,
    this.title,
    this.jobCategory,
    this.salary_from,
    this.salary_to,
    this.jobDate,
    this.jobCreated,
    this.jobType,
    this.is_closed_job,
  });

  factory PostedItem.fromJson(Map<String, dynamic> json) => PostedItem(
        id: json["id"],
        requestsCount: json["requests_count"],
        title: json["title"],
        jobCategory: json["job_category"],
        salary_from: json["salary_from"],
        salary_to: json["salary_to"],
        jobDate:
            json["job_date"] == null ? null : DateTime.parse(json["job_date"]),
        jobCreated: json["job_created"] == null
            ? null
            : DateTime.parse(json["job_created"]),
        jobType: json["job_type"],
        is_closed_job: json["is_closed_job"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "requests_count": requestsCount,
        "title": title,
        "job_category": jobCategory,
        "salary": salary_from,
        "salary_to":salary_to,
        "job_date":
            "${jobDate!.year.toString().padLeft(4, '0')}-${jobDate!.month.toString().padLeft(2, '0')}-${jobDate!.day.toString().padLeft(2, '0')}",
        "job_created": jobCreated?.toIso8601String(),
        "job_type": jobType,
        "is_closed_job":"is_closed_job"
      };
}
