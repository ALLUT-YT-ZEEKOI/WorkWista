
class JobItem {
  String? id;
  String? title;
  JobCategory? jobCategory;
  String? salary;
  DateTime? jobDate;
  DateTime? jobCreated;
  JobCategory? jobType;

  JobItem({
    this.id,
    this.title,
    this.jobCategory,
    this.salary,
    this.jobDate,
    this.jobCreated,
    this.jobType,
  });

  factory JobItem.fromJson(Map<String, dynamic> json) => JobItem(
        id: json["id"],
        title: json["title"],
        jobCategory: json["job_category"] == null ? null : JobCategory.fromJson(json["job_category"]),
        salary: json["salary"],
        jobDate: json["job_date"] == null ? null : DateTime.parse(json["job_date"]),
        jobCreated: json["job_created"] == null ? null : DateTime.parse(json["job_created"]),
        jobType: json["job_type"] == null ? null : JobCategory.fromJson(json["job_type"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "job_category": jobCategory?.toJson(),
        "salary": salary,
        "job_date": jobDate?.toIso8601String(),
        "job_created": jobCreated?.toIso8601String(),
        "job_type": jobType?.toJson(),
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