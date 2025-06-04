// To parse this JSON data, do
//
//     final jobCompletionModel = jobCompletionModelFromJson(jsonString);

import 'dart:convert';

JobCompletionModel jobCompletionModelFromJson(String str) =>
    JobCompletionModel.fromJson(json.decode(str));

String jobCompletionModelToJson(JobCompletionModel data) =>
    json.encode(data.toJson());

class JobCompletionModel {
  String? message;
  CompletedJobData? data;

  JobCompletionModel({
    this.message,
    this.data,
  });

  factory JobCompletionModel.fromJson(Map<String, dynamic> json) =>
      JobCompletionModel(
        message: json["message"],
        data: json["data"] == null
            ? null
            : CompletedJobData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
      };
}

class CompletedJobData {
  String? id;
  Job? job;
  bool? isCompleted;
  String? jobberName;
  String? workerPhoneNumber;
  bool? isUserJobber;
  bool? isUserRecruter;
  bool? isPaid;

  CompletedJobData({
    this.id,
    this.job,
    this.isCompleted,
    this.jobberName,
    this.workerPhoneNumber,
    this.isUserJobber,
    this.isUserRecruter,
    this.isPaid,
  });

  factory CompletedJobData.fromJson(Map<String, dynamic> json) =>
      CompletedJobData(
        id: json["id"],
        job: json["job"] == null ? null : Job.fromJson(json["job"]),
        isCompleted: json["is_completed"],
        jobberName: json["jobber_name"],
        workerPhoneNumber: json["worker_phone_number"],
        isUserJobber: json["is_user_jobber"],
        isUserRecruter: json["is_user_recruter"],
        isPaid: json["is_paid"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "job": job?.toJson(),
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
  JobCategory? jobCategory;
  String? salaryFrom;
  String? salaryTo;
  DateTime? jobDate;
  DateTime? jobCreated;
  JobType? jobType;
  String? manualLocation;
  String? jobRecruter;

  Job({
    this.id,
    this.title,
    this.jobCategory,
    this.salaryFrom,
    this.salaryTo,
    this.jobDate,
    this.jobCreated,
    this.jobType,
    this.manualLocation,
    this.jobRecruter,
  });

  factory Job.fromJson(Map<String, dynamic> json) => Job(
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
        jobRecruter: json["job_recruter"],
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
        "job_recruter": jobRecruter,
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
