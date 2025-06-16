import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workwista/view/Model/payment_create_model.dart';

class PaymentController with ChangeNotifier {
  bool isLoading = false;
  String? generalError;
  PaymentCreateModel? paymentData;

  Map<String, String?> fieldErrors = {"amount": null};

  void clearErrors() {
    fieldErrors.updateAll((key, value) => null);
    generalError = null;
  }

  Future<PaymentCreateModel?> createPayment({
    required int amount,
    required String id,
    required BuildContext context,
  }) async {
    isLoading = true;
    clearErrors();
    paymentData = null;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      String accessToken = prefs.getString("access") ?? "";

      // Make initial request
      var response = await _makePaymentCreateRequest(accessToken,id, amount);

      // If token expired, refresh and retry
      if (response.statusCode == 401) {
        log("Access token expired, trying to refresh...");
        final refreshToken = prefs.getString("refresh") ?? "";

        final newAccessToken = await _refreshToken(refreshToken);
        if (newAccessToken != null) {
          response = await _makePaymentCreateRequest(newAccessToken, id, amount);
        }
      }

      // Handle response
      if (response.statusCode == 200) {
        PaymentCreateModel paymentModel = paymentCreateModelFromJson(
          response.body,
        );
        paymentData = paymentModel;
        log("Payment session created successfully");
        log("Session ID: ${paymentModel.sessionId}");
        log("Order ID: ${paymentModel.orderId}");
        return paymentModel;
      } else if (response.statusCode == 400) {
        final decoded = json.decode(response.body);
        decoded.forEach((key, value) {
          if (fieldErrors.containsKey(key)) {
            fieldErrors[key] = (value as List).join(', ');
          } else {
            generalError = (value as List).join(', ');
          }
        });
      } else {
        generalError =
            "Failed to create payment session (${response.statusCode})";
        log(response.body);
      }
    } catch (e) {
      generalError = "Connection error: ${e.toString()}";
      log(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();

      if (generalError != null && context.mounted) {
        log(generalError.toString());
      }
    }

    return null;
  }

  Future<http.Response> _makePaymentCreateRequest(String token,String id, int amount) async {
    final url = Uri.parse(
      "https://workwista.com/pay/create/$id/",
    );

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({'amount': amount}),
    );

    log("Payment request body: ${json.encode({'amount': amount})}");
    log("Payment response: ${response.body}");

    return response;
  }

  Future<String?> _refreshToken(String refreshToken) async {
    final url = Uri.parse("https://workwista.com/account/token/refresh/");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode({"refresh": refreshToken}),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final newAccessToken = jsonData['access'];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("access", newAccessToken);
      log("Token refreshed successfully");
      return newAccessToken;
    } else {
      log("Token refresh failed: ${response.body}");
      return null;
    }
  }
}
