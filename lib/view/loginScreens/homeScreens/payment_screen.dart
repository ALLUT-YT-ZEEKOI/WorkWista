import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

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

  const ExpandableSection(
      {Key? key,
      required this.title,
      required this.processingFee,
      required this.totalAmount})
      : super(key: key);

  @override
  State<ExpandableSection> createState() => _ExpandableSectionState();
}

class _ExpandableSectionState extends State<ExpandableSection> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // Header section (always visible)
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
