// To parse this JSON data, do
//
//     final jobListResponseModel = jobListResponseModelFromJson(jsonString);

import 'dart:convert';

MyJobsCompletedJobsModel myJobsCompletedJobsModelFromJson(String str) =>
    MyJobsCompletedJobsModel.fromJson(json.decode(str));

String myJobsCompletedJobsModelToJson(MyJobsCompletedJobsModel data) =>
    json.encode(data.toJson());

class MyJobsCompletedJobsModel {
  int? status;
  List<MyJobsCompletedItem>? data;

  MyJobsCompletedJobsModel({
    this.status,
    this.data,
  });

  factory MyJobsCompletedJobsModel.fromJson(Map<String, dynamic> json) =>
      MyJobsCompletedJobsModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<MyJobsCompletedItem>.from(
                json["data"].map((x) => MyJobsCompletedItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class MyJobsCompletedItem {
  String? id;
  Job? job;
  bool? isCompleted;
  String? jobberName;
  String? workerPhoneNumber;
  bool? isUserJobber;
  bool? isUserRecruter;
  bool? isPaid;

  MyJobsCompletedItem({
    this.id,
    this.job,
    this.isCompleted,
    this.jobberName,
    this.workerPhoneNumber,
    this.isUserJobber,
    this.isUserRecruter,
    this.isPaid,
  });

  factory MyJobsCompletedItem.fromJson(Map<String, dynamic> json) => MyJobsCompletedItem(
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
