import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:workwista/Utils/color_constants.dart';
import 'package:workwista/view/Wdigets/button_without_gradient.dart';
import 'package:workwista/view/Wdigets/gradient_button.dart';
import 'package:workwista/view/responsive_helper.dart';

class EnterJobDetailsScreen extends StatefulWidget {
  const EnterJobDetailsScreen({super.key});

  @override
  State<EnterJobDetailsScreen> createState() => _EnterJobDetailsScreenState();
}

class _EnterJobDetailsScreenState extends State<EnterJobDetailsScreen> {
  int? _selectedJobType; // For job type selection
  int? _selectedWorkMode; // For work mode selection
  TextEditingController _jobTitleController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _skillsController = TextEditingController();
  TextEditingController _salaryPeriodController = TextEditingController();
  TextEditingController _positionController = TextEditingController();
  TextEditingController _salaryFromController = TextEditingController();
  TextEditingController _salaryToController = TextEditingController();
  TextEditingController _dateFromController = TextEditingController();
  TextEditingController _dateToController = TextEditingController();
  TextEditingController _startTimeController = TextEditingController();
  TextEditingController _endTimeController = TextEditingController();
  final List<Map<String, dynamic>> _jobTypes = [
    {'label': 'Fulltime', 'value': 1},
    {'label': 'Parttime', 'value': 2},
    {'label': 'Permanent', 'value': 3},
  ];

  final List<Map<String, dynamic>> _workModes = [
    {'label': 'Onsite', 'value': 1},
    {'label': 'Work from home', 'value': 2},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Enter some details",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveHelper.width(10, context),
          vertical: ResponsiveHelper.height(15, context),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Image Upload Section
              InkWell(
                onTap: () => log("add a photo"),
                child: Container(
                  width: double.infinity,
                  height: ResponsiveHelper.height(179, context),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: ColorConstants.containerBorder,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(24),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_photo_alternate, size: 26),
                      Text(
                        "Upload more images",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: ResponsiveHelper.height(12, context)),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _jobTypes.map((jobType) {
                  return _buildSelectionContainer(
                    context: context,
                    label: jobType['label'],
                    value: jobType['value'],
                    groupValue: _selectedJobType,
                    onChanged: (value) {
                      setState(() {
                        _selectedJobType = value;
                        log("Selected Job Type: ${jobType['label']}");
                      });
                    },
                  );
                }).toList(),
              ),

              SizedBox(height: ResponsiveHelper.height(12, context)),

              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: ResponsiveHelper.width(10, context)),
                child: Row(
                  children: _workModes.map((workMode) {
                    return Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: _buildSelectionContainer(
                        context: context,
                        label: workMode['label'],
                        value: workMode['value'],
                        groupValue: _selectedWorkMode,
                        onChanged: (value) {
                          setState(() {
                            _selectedWorkMode = value;
                            log("Selected Work Mode: ${workMode['label']}");
                          });
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: ResponsiveHelper.height(12, context)),
              _textFields(context, double.infinity, "Describe your Job role*",
                  _jobTitleController),
              SizedBox(height: ResponsiveHelper.height(12, context)),
              _textFields(
                  context, double.infinity, "Ad Title*", _titleController),
              SizedBox(height: ResponsiveHelper.height(12, context)),
              _textFields(
                  context, double.infinity, "Skills*", _skillsController),
              SizedBox(height: ResponsiveHelper.height(12, context)),
              _textFields(context, double.infinity, "Salary Period*",
                  _salaryPeriodController),
              SizedBox(height: ResponsiveHelper.height(12, context)),
              _textFields(context, double.infinity, "Position type*",
                  _positionController),
              SizedBox(height: ResponsiveHelper.height(12, context)),
              _textFields(context, double.infinity, "Salary From*",
                  _salaryFromController),
              SizedBox(height: ResponsiveHelper.height(12, context)),
              _textFields(
                  context, double.infinity, "Salary To*", _salaryToController),
              SizedBox(height: ResponsiveHelper.height(12, context)),
              _textFields(
                  context, double.infinity, "Date From*", _dateFromController),
              SizedBox(height: ResponsiveHelper.height(12, context)),
              _textFields(
                  context, double.infinity, "Date To*", _dateToController),
              SizedBox(height: ResponsiveHelper.height(20, context)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _textFields(context, 175, "00: 00*", _startTimeController),
                  _textFields(context, 175, "00: 00*", _endTimeController),
                ],
              ),
              SizedBox(height: ResponsiveHelper.height(20, context)),
              GradientButton(
                height: 44,
                width: 373,
                name: "Next",
              ),
              ButtonWithoutGradient(name: "Backk")
            ],
          ),
        ),
      ),
    );
  }

  SizedBox _textFields(BuildContext context, double width, String hint,
      TextEditingController controller) {
    return SizedBox(
      width: ResponsiveHelper.width(width, context),
      height: ResponsiveHelper.height(50, context),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: ColorConstants.descText),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: ColorConstants.containerBorder.withOpacity(0.1),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSelectionContainer({
    required BuildContext context,
    required String label,
    required int value,
    required int? groupValue,
    required ValueChanged<int?> onChanged,
  }) {
    return GestureDetector(
      onTap: () => onChanged(value),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveHelper.width(8, context),
        ),
        constraints: BoxConstraints(
          minWidth: ResponsiveHelper.width(105, context),
        ),
        height: ResponsiveHelper.height(44, context),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: ColorConstants.containerBorder,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: Radio<int>(
                value: value,
                groupValue: groupValue,
                onChanged: onChanged,
                activeColor: Colors.blue,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
            SizedBox(width: ResponsiveHelper.width(6, context)),
            Text(
              label,
              style: TextStyle(
                color: Colors.black,
                fontSize: ResponsiveHelper.fontSize(14, context),
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
