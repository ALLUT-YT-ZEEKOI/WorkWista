import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:workwista/Utils/color_constants.dart';
import 'package:workwista/main.dart';
import 'package:workwista/view/Controllers/add_job_controller.dart';
import 'package:workwista/view/Wdigets/button_without_gradient.dart';
import 'package:workwista/view/Wdigets/gradient_button.dart';
import 'package:workwista/view/responsive_helper.dart';

class EnterJobDetailsScreen extends StatefulWidget {
  String? category_id;
  EnterJobDetailsScreen({required this.category_id, super.key});

  @override
  State<EnterJobDetailsScreen> createState() => _EnterJobDetailsScreenState();
}

class _EnterJobDetailsScreenState extends State<EnterJobDetailsScreen> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  int? _selectedJobType; // For job type selection
  int? _selectedWorkMode; // For work mode selection
  TextEditingController _jobTitleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _jobdateController = TextEditingController();
  TextEditingController _salaryController = TextEditingController();
  TextEditingController _longitudeController = TextEditingController();
  TextEditingController _latitudeController = TextEditingController();
  TextEditingController _jobtypeController = TextEditingController();
  TextEditingController _dateFromController = TextEditingController();
  TextEditingController _dateToController = TextEditingController();
  TextEditingController _startTimeController = TextEditingController();
  TextEditingController _endTimeController = TextEditingController();
  final List<Map<String, dynamic>> _jobTypes = [
    {
      'label': 'Fulltime',
      'value': 1,
      'keyword': '16c2da6b-6a84-4b84-bae5-c9c9aa165623'
    },
    {
      'label': 'Parttime',
      'value': 2,
      'keyword': '10548fac-0b67-4da2-80be-2543729ef987'
    },
    {'label': 'Permanent', 'value': 3, 'keyword': 'cd'},
  ];

  final List<Map<String, dynamic>> _workModes = [
    {'label': 'Onsite', 'value': 1, 'keyword': 'xy'},
    {'label': 'Work from home', 'value': 2, 'keyword': 'yz'},
  ];

  @override
  Widget build(BuildContext context) {
    Future<void> _pickImage() async {
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery); // or camera

      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: InkWell(
          onTap: () {
            final selectedJobType = _jobTypes.firstWhere(
              (e) => e['value'] == _selectedJobType,
              orElse: () => {},
            );
            final selectedWorkMode = _workModes.firstWhere(
              (e) => e['value'] == _selectedWorkMode,
              orElse: () => {},
            );

            log("Selected Job Type Keyword: ${selectedJobType['keyword'] ?? 'None'}");
            log("Selected Work Mode Keyword: ${selectedWorkMode['keyword'] ?? 'None'}");
          },
          child: Text(
            "Enter some details",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
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
                onTap: () => _pickImage(),
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
                  child: _selectedImage == null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.add_photo_alternate, size: 26),
                            Text(
                              "Upload more images",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                          ],
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Image.file(
                            _selectedImage!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
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
              _textFields(
                  context, double.infinity, "title*", _jobTitleController),
              SizedBox(height: ResponsiveHelper.height(12, context)),
              _textFields(context, double.infinity, "description",
                  _descriptionController),
              SizedBox(height: ResponsiveHelper.height(12, context)),
              _textFields(
                  context, double.infinity, "Job date*", _jobdateController),
              SizedBox(height: ResponsiveHelper.height(12, context)),
              _textFields(
                  context, double.infinity, "Salary*", _salaryController),
              SizedBox(height: ResponsiveHelper.height(12, context)),
              _textFields(
                  context, double.infinity, "longitude", _longitudeController),
              SizedBox(height: ResponsiveHelper.height(12, context)),
              _textFields(
                  context, double.infinity, "latitude", _latitudeController),
              SizedBox(height: ResponsiveHelper.height(12, context)),
              _textFields(
                  context, double.infinity, "job_type", _jobtypeController),
              SizedBox(height: ResponsiveHelper.height(12, context)),
              // _textFields(
              //     context, double.infinity, "Date From*", _dateFromController),
              // SizedBox(height: ResponsiveHelper.height(12, context)),
              // _textFields(
              //     context, double.infinity, "Date To*", _dateToController),
              // SizedBox(height: ResponsiveHelper.height(20, context)),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     _textFields(context, 175, "00: 00*", _startTimeController),
              //     _textFields(context, 175, "00: 00*", _endTimeController),
              //   ],
              // ),
              SizedBox(height: ResponsiveHelper.height(20, context)),
              GradientButton(
                onPressed: () async {
                  final selectedJobType = _jobTypes.firstWhere(
                    (e) => e['value'] == _selectedJobType,
                    orElse: () => {},
                  );
                  

                  log("Selected Job Type Keyword: ${selectedJobType['keyword'] ?? 'None'}");
                  // log("Selected Work Mode Keyword: ${selectedWorkMode['keyword'] ?? 'None'}");

                  if (_jobTitleController.text.isNotEmpty &&
                      _descriptionController.text.isNotEmpty &&
                      _jobdateController.text.isNotEmpty &&
                      _salaryController.text.isNotEmpty &&
                      _longitudeController.text.isNotEmpty &&
                      _latitudeController.text.isNotEmpty) {
                    await context.read<AddJobController>().onAddJob(
                        title: _jobTitleController.text,
                        description: _descriptionController.text,
                        job_date: _jobdateController.text,
                        context: context,
                        job_image: _selectedImage,
                        salary: _salaryController.text,
                        longitude: _longitudeController.text,
                        latitude: _latitudeController.text,
                        job_category: widget.category_id,
                        job_type: selectedJobType['keyword'] ?? 'None');
                  }
                },
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
