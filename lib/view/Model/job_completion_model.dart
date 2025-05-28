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
  String? jobTitle;
  String? recruterName;
  bool? isCompleted;
  String? jobberName;
  String? workerPhoneNumber;
  bool? isUserJobber;
  bool? isUserRecruter;
  bool? isPaid;

  CompletedJobData({
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

  factory CompletedJobData.fromJson(Map<String, dynamic> json) =>
      CompletedJobData(
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