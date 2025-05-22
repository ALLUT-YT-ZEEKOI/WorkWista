import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  bool _isLoadingLocation = false;
  bool _validateSelections() {
    bool isValid = true;

    // Validate job type selection
    if (_selectedJobTypeId == null || _selectedJobTypeId!.isEmpty) {
      setState(() {
        _jobTypeError = true;
      });
      isValid = false;
    } else {
      setState(() {
        _jobTypeError = false;
      });
    }

    // Validate work mode selection
    if (_selectedWorkMode == null || _selectedWorkMode!.isEmpty) {
      setState(() {
        _workModeError = true;
      });
      isValid = false;
    } else {
      setState(() {
        _workModeError = false;
      });
    }

    return isValid;
  }

  bool _jobTypeError = false;
  bool _workModeError = false;
  final _formKey = GlobalKey<FormState>();

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
    setState(() {
      _isLoadingLocation = true; // Start loading
    });

    try {
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
            _isLoadingLocation = false; // Stop loading
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
            _isLoadingLocation = false; // Stop loading
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
        _isLoadingLocation = false; // Stop loading
      });
    } catch (e) {
      setState(() {
        _location = 'Error getting location: $e';
        _isLoadingLocation = false; // Stop loading on error
      });
      log('Location error: $e');
    }
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0, // remove shadow
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: InkWell(
          onTap: () {
            log("Selected Job Type ID: $_selectedJobTypeId");
            log("Selected Work Mode: $_selectedWorkMode");
          },
          child: Text(
            "Enter some details",
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: Stack(children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10.w,
            vertical: 0.h,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 15.h,
                  ),
                  // Image Upload Section
                  InkWell(
                    onTap: _pickImage,
                    child: Container(
                      width: double.infinity,
                      height: 179.h,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: ColorConstants.containerBorder,
                          width: 1.w,
                        ),
                        borderRadius: BorderRadius.circular(24.r),
                        color: Colors.white,
                      ),
                      child: _selectedImage == null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add_photo_alternate, size: 26),
                                Text(
                                  "Upload more images",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(24.r),
                              child: Image.file(
                                _selectedImage!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                    ),
                  ),

                  SizedBox(height: 12.h),

                  // Job Types from API
                  Consumer<JobsScreenController>(
                    builder: (context, jobsController, child) {
                      if (jobsController.jobtypeslist.isEmpty) {
                        return const CircularProgressIndicator();
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children:
                                jobsController.jobtypeslist.map((jobType) {
                              return Padding(
                                padding: EdgeInsets.only(right: 6.5.w),
                                child: _buildSelectionContainer(
                                  context: context,
                                  label: jobType.title ?? 'Unknown',
                                  value:
                                      jobType.id ?? '', // Ensure non-null value
                                  groupValue: _selectedJobTypeId,
                                  hasError: _jobTypeError,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedJobTypeId = value;
                                      _jobTypeError = false;
                                    });
                                  },
                                ),
                              );
                            }).toList(),
                          ),

                          // Error text for job type
                          if (_jobTypeError)
                            Padding(
                              padding: EdgeInsets.only(top: 4.h, left: 12.w),
                              child: Text(
                                'Please select a job type',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),

                  SizedBox(height: 12.h),

                  // Work Modes
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: _workModes.map((workMode) {
                            return Padding(
                              padding: EdgeInsets.only(right: 6.5.w),
                              child: _buildSelectionContainer(
                                context: context,
                                label: workMode['label'],
                                value: workMode['value'],
                                groupValue: _selectedWorkMode,
                                hasError: _workModeError,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedWorkMode = value;
                                    _workModeError = false;
                                  });
                                },
                              ),
                            );
                          }).toList(),
                        ),
                        if (_workModeError)
                          Padding(
                            padding: EdgeInsets.only(top: 4.h, left: 12.w),
                            child: Text(
                              'Please select a work mode',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),
                  _textFields(
                    context,
                    double.infinity,
                    "title*",
                    _jobTitleController,
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Required' : null,
                  ),
                  SizedBox(height: 12.h),
                  _textFields(
                    context,
                    double.infinity,
                    "description",
                    _descriptionController,
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Required' : null,
                  ),
                  SizedBox(height: 12.h),
                  _textFields(
                    context,
                    double.infinity,
                    "Job date*",
                    _jobdateController,
                    ontap: () => _selectDate(context),
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Required' : null,
                  ),
                  SizedBox(height: 12.h),
                  _textFields(
                    context,
                    double.infinity,
                    "Salary*",
                    _salaryController,
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Required' : null,
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            _textFields(
                              context,
                              double.infinity,
                              "longitude",
                              _longitudeController,
                              validator: (value) =>
                                  value == null || value.isEmpty
                                      ? 'Required'
                                      : null,
                            ),
                            SizedBox(
                                height: ResponsiveHelper.height(12, context)),
                            _textFields(
                              context,
                              double.infinity,
                              "latitude",
                              _latitudeController,
                              validator: (value) =>
                                  value == null || value.isEmpty
                                      ? 'Required'
                                      : null,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                          onPressed: _isLoadingLocation ? null : _getLocation,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _isLoadingLocation
                                ? Colors.grey.shade300
                                : Colors.transparent,
                            foregroundColor: _isLoadingLocation
                                ? Colors.grey.shade600
                                : Colors.white,
                            padding: EdgeInsets.symmetric(
                                vertical: 10.h, horizontal: 10.w),
                          ),
                          child: _isLoadingLocation
                              ? SizedBox(
                                  width: 16.w,
                                  height: 16.h,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.grey.shade600,
                                    ),
                                  ),
                                )
                              : Center(child: Text("Get Current Location")),
                        ),
                      ),
                    ],
                  ),

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
                  SizedBox(height: 20.h),
                  GradientButton(
                    onPressed: () async {
                      bool formValid = _formKey.currentState!.validate();
                      bool selectionsValid = _validateSelections();

                      if (formValid && selectionsValid) {
                        // All fields are filled correctly — proceed with add job
                        await context.read<AddJobController>().onAddJob(
                              title: _jobTitleController.text,
                              description: _descriptionController.text,
                              job_date: _jobdateController.text,
                              context: context,
                              job_image: _selectedImage,
                              salary: _salaryController.text,
                              longitude:
                                  _trimLastDecimal(_longitudeController.text),
                              latitude:
                                  _trimLastDecimal(_latitudeController.text),
                              job_category: widget.category_id,
                              job_type: _selectedJobTypeId!,
                            );
                      }
                      // else: error borders will be shown automatically!
                    },
                    height: 44.h,
                    width: 373.w,
                    name: "Next",
                  ),

                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: ButtonWithoutGradient(name: "Back"))
                ],
              ),
            ),
          ),
        ),
        if (_isLoadingLocation)
          Container(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.5), // Semi-transparent background
            child: Center(
              child: Container(
                padding: EdgeInsets.all(24.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      // ignore: deprecated_member_use
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Getting your location...',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'This may take a few seconds',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
      ]),
    );
  }

  Widget _buildSelectionContainer({
    required BuildContext context,
    required String label,
    required String value,
    required String? groupValue,
    required ValueChanged<String?> onChanged,
    bool hasError = false,
  }) {
    return GestureDetector(
      onTap: () => onChanged(value),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
        ),
        constraints: BoxConstraints(
          minWidth: 105.w,
        ),
        height: 44.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: hasError ? Colors.red : ColorConstants.containerBorder,
            width: hasError ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 16.w,
              height: 16.h,
              child: Radio<String>(
                value: value,
                groupValue: groupValue,
                onChanged: onChanged,
                activeColor: Colors.blue,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
            SizedBox(width: 11.w),
            Text(
              label,
              style: TextStyle(
                color: hasError ? Colors.red : Colors.black,
                fontSize: ResponsiveHelper.fontSize(14.sp, context),
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
    String? Function(String?)? validator,
  }) {
    return SizedBox(
      width: ResponsiveHelper.width(width, context),
      height: 50.h,
      child: TextFormField(
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
          // Disable error text to prevent height change
          errorStyle: TextStyle(height: 0, fontSize: 0),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.red, width: 2), // Make error more visible
              borderRadius: BorderRadius.circular(12.r)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorConstants.containerBorder),
              borderRadius: BorderRadius.circular(12.r)),
          hintText: hint,
          hintStyle: TextStyle(color: ColorConstants.descText),
          filled: true,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorConstants.containerBorder),
              borderRadius: BorderRadius.circular(12.r)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: ColorConstants.containerBorder),
          ),
        ),
        onTap: ontap,
      ),
    );
  }
}
