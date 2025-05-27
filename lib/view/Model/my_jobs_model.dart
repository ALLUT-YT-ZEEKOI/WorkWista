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
  String? id;
  String? jobTitle;
  String? recruterName;
  bool? isCompleted;
  String? jobberName;
  String? workerPhoneNumber;
  bool? isUserJobber;
  bool? isUserRecruter;
  bool? isPaid;

  JobList({
    this.id,
    this.jobTitle,
    this.recruterName,
    this.isCompleted,
    this.jobberName,
    this.workerPhoneNumber,
    this.isUserJobber,
    this.isUserRecruter,
    this.isPaid,
  });

  factory JobList.fromJson(Map<String, dynamic> json) => JobList(
        id: json["id"],
        jobTitle: json["job_title"],
        recruterName: json["recruter_name"],
        isCompleted: json["is_completed"],
        jobberName: json["jobber_name"],
        workerPhoneNumber: json["worker_phone_number"],
        isUserJobber: json["is_user_jobber"],
        isUserRecruter: json["is_user_recruter"],
        isPaid: json["is_paid"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "job_title": jobTitle,
        "recruter_name": recruterName,
        "is_completed": isCompleted,
        "jobber_name": jobberName,
        "worker_phone_number": workerPhoneNumber,
        "is_user_jobber": isUserJobber,
        "is_user_recruter": isUserRecruter,
        "is_paid": isPaid,
      };
}