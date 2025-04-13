// To parse this JSON data, do
//
//     final jobsByCategoryModel = jobsByCategoryModelFromJson(jsonString);

import 'dart:convert';


import 'package:workwista/view/Model/job_item_model.dart';

JobsByCategoryModel jobsByCategoryModelFromJson(String str) => JobsByCategoryModel.fromJson(json.decode(str));

String jobsByCategoryModelToJson(JobsByCategoryModel data) => json.encode(data.toJson());

class JobsByCategoryModel {
    String? status;
    List<JobItem>? data;

    JobsByCategoryModel({
        this.status,
        this.data,
    });

    factory JobsByCategoryModel.fromJson(Map<String, dynamic> json) => JobsByCategoryModel(
        status: json["status"],
        data: json["data"] == null ? [] : List<JobItem>.from(json["data"]!.map((x) => JobItem.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    String? id;
    String? title;
    Job? jobCategory;
    String? salary;
    DateTime? jobDate;
    DateTime? jobCreated;
    Job? jobType;

    Datum({
        this.id,
        this.title,
        this.jobCategory,
        this.salary,
        this.jobDate,
        this.jobCreated,
        this.jobType,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        jobCategory: json["job_category"] == null ? null : Job.fromJson(json["job_category"]),
        salary: json["salary"],
        jobDate: json["job_date"] == null ? null : DateTime.parse(json["job_date"]),
        jobCreated: json["job_created"] == null ? null : DateTime.parse(json["job_created"]),
        jobType: json["job_type"] == null ? null : Job.fromJson(json["job_type"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "job_category": jobCategory?.toJson(),
        "salary": salary,
        "job_date": "${jobDate!.year.toString().padLeft(4, '0')}-${jobDate!.month.toString().padLeft(2, '0')}-${jobDate!.day.toString().padLeft(2, '0')}",
        "job_created": jobCreated?.toIso8601String(),
        "job_type": jobType?.toJson(),
    };
}

class Job {
    String? id;
    String? title;

    Job({
        this.id,
        this.title,
    });

    factory Job.fromJson(Map<String, dynamic> json) => Job(
        id: json["id"],
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
    };
}
