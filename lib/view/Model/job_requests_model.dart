// job_requests_model.dart
import 'dart:convert';

JobRequestsModel jobRequestsModelFromJson(String str) => JobRequestsModel.fromJson(json.decode(str));
String jobRequestsModelToJson(JobRequestsModel data) => json.encode(data.toJson());
class JobRequestsModel {
    String? message;
    List<RequestData>? data; // Changed from Datum to RequestData

    JobRequestsModel({
        this.message,
        this.data,
    });

    factory JobRequestsModel.fromJson(Map<String, dynamic> json) => JobRequestsModel(
        message: json["message"],
        data: json["data"] == null ? [] : List<RequestData>.from(json["data"]!.map((x) => RequestData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class RequestData { // Renamed from Datum to RequestData
    String? id;
    double? applicantId;
    String? applicantName;
    DateTime? requesteDate;
    bool? isAccepted;
    bool? isRejected;
    String? applicantEmail;

    RequestData({ // Changed constructor name
        this.id,
        this.applicantId,
        this.applicantName,
        this.requesteDate,
        this.isAccepted,
        this.isRejected,
        this.applicantEmail,
    });

    factory RequestData.fromJson(Map<String, dynamic> json) => RequestData(
        id: json["id"],
        applicantId: json["applicant_id"]?.toDouble(),
        applicantName: json["applicant_name"],
        requesteDate: json["requeste_date"] == null ? null : DateTime.parse(json["requeste_date"]),
        isAccepted: json["is_accepted"],
        isRejected: json["is_rejected"],
        applicantEmail: json["applicant_email"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "applicant_id": applicantId,
        "applicant_name": applicantName,
        "requeste_date": requesteDate?.toIso8601String(),
        "is_accepted": isAccepted,
        "is_rejected": isRejected,
        "applicant_email": applicantEmail,
    };
}