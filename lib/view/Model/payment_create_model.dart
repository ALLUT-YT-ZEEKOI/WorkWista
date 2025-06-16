// payment_create_model.dart
import 'dart:convert';

PaymentCreateModel paymentCreateModelFromJson(String str) => PaymentCreateModel.fromJson(json.decode(str));

String paymentCreateModelToJson(PaymentCreateModel data) => json.encode(data.toJson());

class PaymentCreateModel {
  String? sessionId;
  String? orderId;

  PaymentCreateModel({
    this.sessionId,
    this.orderId,
  });

  factory PaymentCreateModel.fromJson(Map<String, dynamic> json) => PaymentCreateModel(
        sessionId: json["session_id"],
        orderId: json["order_id"],
      );

  Map<String, dynamic> toJson() => {
        "session_id": sessionId,
        "order_id": orderId,
      };
}