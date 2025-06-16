import 'job_item_model.dart';

class JobsByCategoryModel {
  int? status;
  int? statusCode;
  List<JobItem>? data;

  JobsByCategoryModel({
    this.status,
    this.statusCode,
    this.data,
  });

  factory JobsByCategoryModel.fromJson(Map<String, dynamic> json) => JobsByCategoryModel(
        status: json["status"],
        statusCode: json["status_code"],
        data: json["data"] == null ? [] : List<JobItem>.from(json["data"].map((x) => JobItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "status_code": statusCode,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
