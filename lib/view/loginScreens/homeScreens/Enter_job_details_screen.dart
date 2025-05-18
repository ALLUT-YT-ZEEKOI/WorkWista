import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:workwista/Utils/color_constants.dart';
import 'package:workwista/view/Controllers/add_job_controller.dart';
import 'package:workwista/view/Controllers/jobs_screen_controller.dart';
import 'package:workwista/view/Wdigets/button_without_gradient.dart';
import 'package:workwista/view/Wdigets/gradient_button.dart';
import 'package:workwista/view/responsive_helper.dart';

// ignore: must_be_immutable
class EnterJobDetailsScreen extends StatefulWidget {
  String? category_id;
  EnterJobDetailsScreen({required this.category_id, super.key});

  @override
  State<EnterJobDetailsScreen> createState() => _EnterJobDetailsScreenState();
}

class _EnterJobDetailsScreenState extends State<EnterJobDetailsScreen> {

String _trimLastDecimal(String input) {
  if (input.contains('.')) {
    List<String> parts = input.split('.');
    if (parts.length == 2 && parts[1].length > 1) {
      // Trim last digit of the decimal part
      String trimmedDecimal = parts[1].substring(0, parts[1].length - 1);
      return '${parts[0]}.$trimmedDecimal';
    }
  }
  return input; // Return original if no trimming is possible
}



  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  String locationText = "Press the button to get location";
  Location location = Location();

  String _location = 'Unknown';
  String? _selectedJobTypeId; // Changed to String for job type ID
  String? _selectedWorkMode; // Changed to String for work mode
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _jobdateController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();

  Future<void> _getLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    // Check if location service is enabled
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        setState(() {
          _location = 'Location service disabled';
        });
        return;
      }
    }

    // Check permission
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        setState(() {
          _location = 'Location permission denied';
        });
        return;
      }
    }

    // Get location
    _locationData = await location.getLocation();

    setState(() {
      log(_locationData.latitude.toString());
      _location =
          'Lat: ${_locationData.latitude}, Lon: ${_locationData.longitude}';
      _latitudeController.text = _locationData.latitude.toString();
      _longitudeController.text = _locationData.longitude.toString();
    });
  }


  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // current date
      firstDate: DateTime(2000), // earliest date
      lastDate: DateTime(2100), // latest date
    );

    if (pickedDate != null) {
      String formattedDate =
          DateFormat('yyyy-MM-dd').format(pickedDate); // format date
      setState(() {
        _jobdateController.text = formattedDate; // set to TextField
      });

      // Now you can use the formattedDate string wherever needed
      print("Selected date: $formattedDate");
    }
  }

  // Updated work modes to use String values
  final List<Map<String, dynamic>> _workModes = [
    {'label': 'Onsite', 'value': '1', 'keyword': 'xy'},
    {'label': 'Work from home', 'value': '2', 'keyword': 'yz'},
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timestamp) async {
      await context.read<JobsScreenController>().getJobTypes();
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _pickImage() async {
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);
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
            log("Selected Job Type ID: $_selectedJobTypeId");
            log("Selected Work Mode: $_selectedWorkMode");
          },
          child: const Text(
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
                onTap: _pickImage,
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
                      ? const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
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

              // Job Types from API
              Consumer<JobsScreenController>(
                builder: (context, jobsController, child) {
                  if (jobsController.jobtypeslist.isEmpty) {
                    return const CircularProgressIndicator();
                  }

                  return Row(
                    children: jobsController.jobtypeslist.map((jobType) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: _buildSelectionContainer(
                          context: context,
                          label: jobType.title ?? 'Unknown',
                          value: jobType.id ?? '', // Ensure non-null value
                          groupValue: _selectedJobTypeId,
                          onChanged: (value) {
                            setState(() {
                              _selectedJobTypeId = value;
                            });
                          },
                        ),
                      );
                    }).toList(),
                  );
                },
              ),

              SizedBox(height: ResponsiveHelper.height(12, context)),

              // Work Modes
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: ResponsiveHelper.width(0, context)),
                child: Row(
                  children: _workModes.map((workMode) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: _buildSelectionContainer(
                        context: context,
                        label: workMode['label'],
                        value: workMode['value'],
                        groupValue: _selectedWorkMode,
                        onChanged: (value) {
                          setState(() {
                            _selectedWorkMode = value;
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
              SizedBox(
                height: ResponsiveHelper.height(12, context),
              ),
              _textFields(context, double.infinity, "description",
                  _descriptionController),
              SizedBox(height: ResponsiveHelper.height(12, context)),
              _textFields(
                  context, double.infinity, "Job date*", _jobdateController,
                  ontap: () => _selectDate(context)),
              SizedBox(
                height: ResponsiveHelper.height(12, context),
              ),
              _textFields(
                  context, double.infinity, "Salary*", _salaryController),
              SizedBox(height: ResponsiveHelper.height(12, context)),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        _textFields(context, double.infinity, "longitude",
                            _longitudeController),
                        SizedBox(height: ResponsiveHelper.height(12, context)),
                        _textFields(context, double.infinity, "latitude",
                            _latitudeController),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: _getLocation,
                      child: const Text("Get Current Location"),
                    ),
                  ),
                ],
              ),

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
                  if (_jobTitleController.text.isNotEmpty &&
                      _descriptionController.text.isNotEmpty &&
                      _jobdateController.text.isNotEmpty &&
                      _salaryController.text.isNotEmpty &&
                      _longitudeController.text.isNotEmpty &&
                      _latitudeController.text.isNotEmpty &&
                      _selectedJobTypeId != null) {
                    await context.read<AddJobController>().onAddJob(
                          title: _jobTitleController.text,
                          description: _descriptionController.text,
                          job_date: _jobdateController.text,
                          context: context,
                          job_image: _selectedImage,
                          salary: _salaryController.text,
                         longitude: _trimLastDecimal(_longitudeController.text),
latitude: _trimLastDecimal(_latitudeController.text),
                          job_category: widget.category_id,
                          job_type: _selectedJobTypeId!,
                        );
                  }
                },
                height: 44,
                width: 373,
                name: "Next",
              ),
              ButtonWithoutGradient(name: "Back")
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSelectionContainer({
    required BuildContext context,
    required String label,
    required String value,
    required String? groupValue,
    required ValueChanged<String?> onChanged,
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
              child: Radio<String>(
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

  SizedBox _textFields(
    BuildContext context,
    double width,
    String hint,
    TextEditingController controller, {
    VoidCallback? ontap,
  }) {
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
              // ignore: deprecated_member_use
              color: ColorConstants.containerBorder.withOpacity(0.1),
            ),
          ),
        ),
        onTap: ontap,
      ),
    );
  }
}
