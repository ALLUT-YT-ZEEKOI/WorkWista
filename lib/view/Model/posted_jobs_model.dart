// To parse this JSON data, do
//
//     final postedJobsModel = postedJobsModelFromJson(jsonString);

import 'dart:convert';

PostedJobsModel postedJobsModelFromJson(String str) => PostedJobsModel.fromJson(json.decode(str));

String postedJobsModelToJson(PostedJobsModel data) => json.encode(data.toJson());

class PostedJobsModel {
    int? status;
    List<PostedItem>? data;

    PostedJobsModel({
        this.status,
        this.data,
    });

    factory PostedJobsModel.fromJson(Map<String, dynamic> json) => PostedJobsModel(
        status: json["status"],
        data: json["data"] == null ? [] : List<PostedItem>.from(json["data"]!.map((x) => PostedItem.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class PostedItem {
    String? id;
    int? requestsCount;
    String? title;
    String? jobCategory;
    String? salary;
    DateTime? jobDate;
    DateTime? jobCreated;
    String? jobType;

    PostedItem({
        this.id,
        this.requestsCount,
        this.title,
        this.jobCategory,
        this.salary,
        this.jobDate,
        this.jobCreated,
        this.jobType,
    });

    factory PostedItem.fromJson(Map<String, dynamic> json) => PostedItem(
        id: json["id"],
        requestsCount: json["requests_count"],
        title: json["title"],
        jobCategory: json["job_category"],
        salary: json["salary"],
        jobDate: json["job_date"] == null ? null : DateTime.parse(json["job_date"]),
        jobCreated: json["job_created"] == null ? null : DateTime.parse(json["job_created"]),
        jobType: json["job_type"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "requests_count": requestsCount,
        "title": title,
        "job_category": jobCategory,
        "salary": salary,
        "job_date": "${jobDate!.year.toString().padLeft(4, '0')}-${jobDate!.month.toString().padLeft(2, '0')}-${jobDate!.day.toString().padLeft(2, '0')}",
        "job_created": jobCreated?.toIso8601String(),
        "job_type": jobType,
    };
}
