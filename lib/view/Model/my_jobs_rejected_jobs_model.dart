// To parse this JSON data, do
//
//     final completedJobsModel = completedJobsModelFromJson(jsonString);

import 'dart:convert';

MyJobsRejectedJobsModel myJobsRejectedJobsModelFromJson(String str) =>
    MyJobsRejectedJobsModel.fromJson(json.decode(str));

String MyJobsRejectedJobsModelToJson(MyJobsRejectedJobsModel data) =>
    json.encode(data.toJson());

class MyJobsRejectedJobsModel {
  int? status;
  List<MyJobsRejectedItem>? data;

  MyJobsRejectedJobsModel({
    this.status,
    this.data,
  });

  factory MyJobsRejectedJobsModel.fromJson(Map<String, dynamic> json) =>
      MyJobsRejectedJobsModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<MyJobsRejectedItem>.from(
                json["data"].map((x) => MyJobsRejectedItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class MyJobsRejectedItem {
  String? id;
  String? jobTitle;
  DateTime? jobDate;
  String? recruterName;
  bool? isCompleted;
  String? jobberName;
  String? workerPhoneNumber;
  bool? isUserJobber;
  bool? isUserRecruter;
  bool? isPaid;

  MyJobsRejectedItem({
    this.id,
    this.jobTitle,
    this.jobDate,
    this.recruterName,
    this.isCompleted,
    this.jobberName,
    this.workerPhoneNumber,
    this.isUserJobber,
    this.isUserRecruter,
    this.isPaid,
  });

  factory MyJobsRejectedItem.fromJson(Map<String, dynamic> json) =>
      MyJobsRejectedItem(
        id: json["id"],
        jobTitle: json["job_title"],
        jobDate:
            json["job_date"] == null ? null : DateTime.parse(json["job_date"]),
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
        "job_date": jobDate?.toIso8601String().split("T").first,
        "recruter_name": recruterName,
        "is_completed": isCompleted,
        "jobber_name": jobberName,
        "worker_phone_number": workerPhoneNumber,
        "is_user_jobber": isUserJobber,
        "is_user_recruter": isUserRecruter,
        "is_paid": isPaid,
      };
}
