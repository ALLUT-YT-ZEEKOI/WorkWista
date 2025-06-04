// To parse this JSON data, do
//
//     final myJobsRejectedJobsModel = myJobsRejectedJobsModelFromJson(jsonString);

import 'dart:convert';

MyJobsPendingJobsModel myJobsPendingJobsModelFromJson(String str) =>
    MyJobsPendingJobsModel.fromJson(json.decode(str));

String myJobsPendingJobsModelToJson(MyJobsPendingJobsModel data) =>
    json.encode(data.toJson());

class MyJobsPendingJobsModel {
  int? status;
  List<MyJobsPendingItem>? data;

  MyJobsPendingJobsModel({
    this.status,
    this.data,
  });

  factory MyJobsPendingJobsModel.fromJson(Map<String, dynamic> json) =>
      MyJobsPendingJobsModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<MyJobsPendingItem>.from(
                json["data"].map((x) => MyJobsPendingItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class MyJobsPendingItem {
  Job? job;
  String? id;
  bool? isCompleted;
  String? jobberName;
  String? workerPhoneNumber;
  bool? isUserJobber;
  bool? isUserRecruter;
  bool? isPaid;

  MyJobsPendingItem({
    this.job,
    this.id,
    this.isCompleted,
    this.jobberName,
    this.workerPhoneNumber,
    this.isUserJobber,
    this.isUserRecruter,
    this.isPaid,
  });

  factory MyJobsPendingItem.fromJson(Map<String, dynamic> json) =>
      MyJobsPendingItem(
        job: json["job"] == null ? null : Job.fromJson(json["job"]),
        id: json["id"],
        isCompleted: json["is_completed"],
        jobberName: json["jobber_name"],
        workerPhoneNumber: json["worker_phone_number"],
        isUserJobber: json["is_user_jobber"],
        isUserRecruter: json["is_user_recruter"],
        isPaid: json["is_paid"],
      );

  Map<String, dynamic> toJson() => {
        "job": job?.toJson(),
        "id": id,
        "is_completed": isCompleted,
        "jobber_name": jobberName,
        "worker_phone_number": workerPhoneNumber,
        "is_user_jobber": isUserJobber,
        "is_user_recruter": isUserRecruter,
        "is_paid": isPaid,
      };
}

class Job {
  String? id;
  String? title;
  String? job_recruter;
  JobCategory? jobCategory;
  String? salaryFrom;
  String? salaryTo;
  DateTime? jobDate;
  DateTime? jobCreated;
  JobType? jobType;
  String? manualLocation;

  Job({
    this.id,
    this.title,
    this.job_recruter,
    this.jobCategory,
    this.salaryFrom,
    this.salaryTo,
    this.jobDate,
    this.jobCreated,
    this.jobType,
    this.manualLocation,
  });

  factory Job.fromJson(Map<String, dynamic> json) => Job(
        id: json["id"],
        title: json["title"],
        job_recruter: json["job_recruter"],
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
        "job_recruter":job_recruter,
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
