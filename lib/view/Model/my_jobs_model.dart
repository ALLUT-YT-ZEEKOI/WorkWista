// To parse this JSON data, do
//
//     final myJobsModel = myJobsModelFromJson(jsonString);

import 'dart:convert';

MyJobsModel myJobsModelFromJson(String str) =>
    MyJobsModel.fromJson(json.decode(str));

String myJobsModelToJson(MyJobsModel data) => json.encode(data.toJson());

class MyJobsModel {
  List<JobList>? asJobber;
  List<JobList>? asRecruter;

  MyJobsModel({
    this.asJobber,
    this.asRecruter,
  });

  factory MyJobsModel.fromJson(Map<String, dynamic> json) => MyJobsModel(
        asJobber: json["as_jobber"] == null
            ? []
            : List<JobList>.from(
                json["as_jobber"]!.map((x) => JobList.fromJson(x))),
        asRecruter: json["as_recruter"] == null
            ? []
            : List<JobList>.from(
                json["as_recruter"]!.map((x) => JobList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "as_jobber": asJobber == null
            ? []
            : List<dynamic>.from(asJobber!.map((x) => x.toJson())),
        "as_recruter": asRecruter == null
            ? []
            : List<dynamic>.from(asRecruter!.map((x) => x.toJson())),
      };
}

class JobList {
  Job? job;
  String? id;
  bool? isCompleted;
  String? jobberName;
  String? workerPhoneNumber;
  bool? isUserJobber;
  bool? isUserRecruter;
  bool? isPaid;

  JobList({
    this.job,
    this.id,
    this.isCompleted,
    this.jobberName,
    this.workerPhoneNumber,
    this.isUserJobber,
    this.isUserRecruter,
    this.isPaid,
  });

  factory JobList.fromJson(Map<String, dynamic> json) => JobList(
        job: json["job"] == null ? null : Job.fromJson(json["job"]),
        isCompleted: json["is_completed"],
        id: json["id"],
        jobberName: json["jobber_name"],
        workerPhoneNumber: json["worker_phone_number"],
        isUserJobber: json["is_user_jobber"],
        isUserRecruter: json["is_user_recruter"],
        isPaid: json["is_paid"],
      );

  Map<String, dynamic> toJson() => {
        "job": job?.toJson(),
        "is_completed": isCompleted,
        "id":id,
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
        "job_recruter": job_recruter,
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
