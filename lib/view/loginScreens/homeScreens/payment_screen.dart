import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_cashfree_pg_sdk/api/cferrorresponse/cferrorresponse.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfdropcheckoutpayment.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentgateway/cfpaymentgatewayservice.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfsession/cfsession.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfenums.dart';
import 'package:provider/provider.dart';
import 'package:workwista/view/Common%20Screens/custom_bottom_navbar.dart';
import 'package:workwista/view/Controllers/payment_controller.dart';
import 'package:workwista/view/Model/payment_create_model.dart';

class PaymentScreen extends StatelessWidget {
  final String id;
  const PaymentScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Payments",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          ExpandableSection(
            title: 'Total amount',
            totalAmount: "1,200",
            processingFee: '50',
            id: id,
          ),
          SizedBox(height: 16),
          PaymentOptionsSection(),
        ],
      ),
    );
  }
}

class ExpandableSection extends StatefulWidget {
  final String title;
  final String processingFee;
  final String totalAmount;
  final String id;

  const ExpandableSection(
      {Key? key,
      required this.title,
      required this.processingFee,
      required this.totalAmount,
      required this.id})
      : super(key: key);

  @override
  State<ExpandableSection> createState() => _ExpandableSectionState();
}

class _ExpandableSectionState extends State<ExpandableSection> {
  bool _isExpanded = false;

  //
  final TextEditingController _amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isPaymentProcessing = false;
  String _paymentStatus = '';

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Initialize Cashfree Payment Gateway
    CFPaymentGatewayService().setCallback(verifyPayment, onError);
  }

  void startCashfreePayment(String paymentSessionId, String orderId) {
    setState(() {
      _isPaymentProcessing = true;
      _paymentStatus = 'Processing payment...';
    });

    var cfPaymentGatewayService = CFPaymentGatewayService();
    // ignore: deprecated_member_use
    var cfDropCheckoutPayment =
        // ignore: deprecated_member_use
        CFDropCheckoutPaymentBuilder()
            .setSession(
              CFSessionBuilder()
                  .setEnvironment(
                    CFEnvironment.PRODUCTION,
                  ) // Change to PRODUCTION for live
                  .setPaymentSessionId(paymentSessionId)
                  .setOrderId(orderId)
                  .build(),
            )
            .build();

    cfPaymentGatewayService.doPayment(cfDropCheckoutPayment);
  }

  void verifyPayment(response) {
    setState(() {
      _isPaymentProcessing = false;
    });

    if (response.txStatus == "SUCCESS") {
      setState(() {
        _paymentStatus =
            'Payment Successful!\nTransaction ID: ${response.referenceId}';
      });
      _showPaymentDialog(
        'Success',
        'Payment completed successfully!\nTransaction ID: ${response.referenceId}',
        Colors.green,
      );
    } else {
      setState(() {
        _paymentStatus = 'Payment Failed!\nReason: ${response.toString()}';
      });
      _showPaymentDialog(
        'Failed',
        'Payment failed. Please try again.',
        Colors.red,
      );
    }
  }

  void onError(CFErrorResponse errorResponse, String orderId) {
    setState(() {
      _isPaymentProcessing = false;
      _paymentStatus = 'Payment Error!\nError: ${errorResponse.getMessage()}';
    });
    _showPaymentDialog(
      'Error',
      'Payment error occurred: ${errorResponse.getMessage()}',
      Colors.orange,
    );
  }

  void _showPaymentDialog(String title, String message, Color color) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(
                title == 'Success' ? Icons.check_circle : Icons.error,
                color: color,
              ),
              SizedBox(width: 10),
              Text(title),
            ],
          ),
          content: Text(message),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                if (title == 'Success') {
                  // Clear the form after successful payment
                  _amountController.clear();
                  setState(() {
                    _paymentStatus = '';
                  });
                  // Navigate back to home screen by replacing current screen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CustomBottomNavbar(
                              initialIndex: 0,
                            )),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _initiatePayment() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final paymentController = Provider.of<PaymentController>(
      context,
      listen: false,
    );
    final amount = int.parse(_amountController.text.trim());

    // First create payment session
    PaymentCreateModel? paymentData = await paymentController.createPayment(
      amount: amount,
      id: widget.id,
      context: context,
    );

    log(paymentData.toString());
    if (paymentData != null &&
        paymentData.sessionId != null &&
        paymentData.orderId != null) {
      // Start Cashfree payment with the received session and order IDs
      startCashfreePayment(paymentData.sessionId!, paymentData.orderId!);
    } else {
      // Payment session creation failed
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to create payment session. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // Header section (always visible)
          Consumer<PaymentController>(
            builder: (context, PaymentController, child) {
              return Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _amountController,
                        decoration: InputDecoration(
                          labelText: 'Amount *',
                          hintText: 'Enter amount to pay',
                          prefixIcon: Icon(Icons.currency_rupee),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: Colors.grey[50],
                          // errorText:
                          //     paymentController.fieldErrors['amount'],
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an amount';
                          }
                          final amount = int.tryParse(value);
                          if (amount == null || amount <= 0) {
                            return 'Please enter a valid amount';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                        onPressed: (PaymentController.isLoading ||
                                _isPaymentProcessing)
                            ? null
                            : _initiatePayment,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[700],
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 5,
                        ),
                        child: (PaymentController.isLoading ||
                                _isPaymentProcessing)
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    PaymentController.isLoading
                                        ? 'Creating Session...'
                                        : 'Processing Payment...',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              )
                            : Text(
                                'Start Payment',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                      SizedBox(height: 30),
                      if (_paymentStatus.isNotEmpty)
                        Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Payment Status:',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  _paymentStatus,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: _paymentStatus.contains('Successful')
                                        ? Colors.green[700]
                                        : _paymentStatus.contains(
                                                  'Failed',
                                                ) ||
                                                _paymentStatus.contains('Error')
                                            ? Colors.red[700]
                                            : Colors.blue[700],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      if (PaymentController.paymentData != null)
                        Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Payment Session Details:',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Session ID: ${PaymentController.paymentData!.sessionId}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                Text(
                                  'Order ID: ${PaymentController.paymentData!.orderId}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ));
            },
          ),

          GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            behavior:
                HitTestBehavior.opaque, // Ensures the entire area is tappable
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Title with arrow next to it
                  Row(
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff00316D)),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        _isExpanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        size: 20,
                        color: Color(0xff00316D),
                      ),
                    ],
                  ),
                  // Text on the right side (where arrow was)
                  Text(
                    widget.totalAmount,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff00316D)),
                  ),
                ],
              ),
            ),
          ),

          // Expandable content
          if (_isExpanded)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    "Processing fee : ",
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    widget.processingFee,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class PaymentOptionsSection extends StatefulWidget {
  @override
  _PaymentOptionsSectionState createState() => _PaymentOptionsSectionState();
}

class _PaymentOptionsSectionState extends State<PaymentOptionsSection> {
  String? _selectedOption;

  final List<Map<String, dynamic>> _paymentMethods = [
    {'title': 'Gpay', 'icon': 'assets/gpay.png'},
    {'title': 'Phonepe', 'icon': 'assets/phonepebg.png'},
    {'title': 'Paytm', 'icon': 'assets/paytm.png'},
    {'title': 'Net Banking', 'icon': 'assets/bank.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _paymentMethods.map((method) {
        final isSelected = _selectedOption == method['title'];
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedOption = method['title'];
                  });
                },
                child: Row(
                  children: [
                    Radio<String>(
                      value: method['title'],
                      groupValue: _selectedOption,
                      onChanged: (value) {
                        setState(() {
                          _selectedOption = value!;
                        });
                      },
                    ),
                    Expanded(
                      child: Text(
                        method['title'],
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Image.asset(method['icon'])
                  ],
                ),
              ),
              if (isSelected)
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 20),
                  child: Container(
                    margin: EdgeInsets.only(top: 0),
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF56A2FF), // Light blue (#56A2FF) on left
                          Color(0xFF00316D), // Dark blue (#00316D) on right
                        ],
                        begin:
                            Alignment.centerLeft, // Gradient starts from left
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: Text(
                        "Pay ₹1,200",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
