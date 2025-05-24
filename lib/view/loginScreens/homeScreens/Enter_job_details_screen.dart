import 'dart:developer';
import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
import 'package:workwista/Utils/color_constants.dart';
import 'package:workwista/view/Controllers/add_job_controller.dart';
import 'package:workwista/view/Controllers/jobs_screen_controller.dart';
import 'package:workwista/view/Controllers/location_provider_controller.dart';
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
  void _showLocationSearchDialog() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return LocationSearchDialog(
          onLocationSelected: (Map<String, dynamic> location) {
            setState(() {
              _locationController.text = location['display_name'];
              // You can also store lat/lon if needed
              // _latitudeController.text = location['lat'];
              // _longitudeController.text = location['lon'];
            });
            Navigator.of(dialogContext).pop();
          },
        );
      },
    );
  }

  int? selectedDay;
  int? selectedMonth;
  int? selectedYear;

  final List<int> days = List.generate(31, (index) => index + 1);
  final List<int> months = List.generate(12, (index) => index + 1);
  final List<int> years = List.generate(11, (index) => 2025 + index);

  Widget _dateDropdown({
    required String hint,
    required int? value,
    required List<int> items,
    required void Function(int?) onChanged,
  }) {
    return DropdownButtonFormField2<int>(
      value: value,
      items: items.map((int item) {
        return DropdownMenuItem<int>(
          value: item,
          child: Text(
            item.toString().padLeft(2, '0'),
            style: TextStyle(fontSize: 14.sp),
          ),
        );
      }).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            color: ColorConstants.containerBorder,
            width: 1.w,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            color: ColorConstants.containerBorder,
            width: 1.w,
          ),
        ),
      ),
      buttonStyleData: ButtonStyleData(
        height: 50.h,
        padding: EdgeInsets.only(left: 12.w, right: 8.w),
      ),
      dropdownStyleData: DropdownStyleData(
        maxHeight: 200.h,
        width: 112.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
        ),
        offset: const Offset(1, -6), // Adjust this to position dropdown
      ),
      iconStyleData: IconStyleData(
        icon: Icon(
          Icons.arrow_drop_down,
          color: ColorConstants.descText,
        ),
        iconSize: 24.w,
      ),
      hint: Text(
        hint,
        style: TextStyle(
          fontSize: 14.sp,
          color: ColorConstants.descText,
        ),
      ),
    );
  }

  void logDate() {
    if (selectedDay != null && selectedMonth != null && selectedYear != null) {
      String formatted =
          '${selectedYear!}-${selectedMonth!.toString().padLeft(2, '0')}-${selectedDay!.toString().padLeft(2, '0')}';
      print('Selected Date: $formatted');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Date Saved: $formatted')));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please select all fields')));
    }
  }

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

  String? _selectedJobTypeId; // Changed to String for job type ID
  String? _selectedWorkMode; // Changed to String for work mode
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final TextEditingController _key_responsibilities = TextEditingController();

  final TextEditingController _salaryFromController = TextEditingController();
  final TextEditingController _salaryToController = TextEditingController();
  late TextEditingController _locationController = TextEditingController();

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
  void dispose() {
    _locationController.dispose();

    // ... dispose other controllers ...
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locationProvider = context.read<LocationProvider>();
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  // Image Upload Section
                  InkWell(
                    onTap: _pickImage,
                    child: Container(
                      width: double.infinity,
                      height: 111.h,
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

                  SizedBox(height: 18.h),
                  Text(
                    "Job type*",
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
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
                  SizedBox(height: 18.h),
                  Text(
                    "Enter title*",
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  _textFields(
                    context,
                    double.infinity,
                    "title*",
                    50,
                    _jobTitleController,
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Required' : null,
                  ),
                  SizedBox(height: 18.h),

                  Row(children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Salary from*",
                            style: TextStyle(
                                fontSize: 14.sp, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          _textFields(
                            context,
                            double.infinity,
                            "salary from",
                            50,
                            _salaryFromController,
                            validator: (value) => value == null || value.isEmpty
                                ? 'Required'
                                : null,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Salary to*",
                            style: TextStyle(
                                fontSize: 14.sp, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          _textFields(
                            context,
                            double.infinity,
                            "salary to",
                            50,
                            _salaryToController,
                            validator: (value) => value == null || value.isEmpty
                                ? 'Required'
                                : null,
                          ),
                        ],
                      ),
                    ),
                  ]),
                  SizedBox(height: 18.h),
                  Text(
                    "Enter your location*",
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(children: [
                    Expanded(
                      flex: 5,
                      child: GestureDetector(
                        onTap: () {
                          _showLocationSearchDialog();
                        },
                        child: AbsorbPointer(
                          child: _textFields(
                            context,
                            double.infinity,
                            "Search location",
                            50,
                            _locationController,
                            validator: (value) => value == null || value.isEmpty
                                ? 'Required'
                                : null,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Expanded(
                      flex: 4,
                      child: InkWell(
                        onTap: () {
                          log("tapped");
                          locationProvider.getCurrentLocationAndCity();
                          if (locationProvider.cityName.isNotEmpty) {
                            setState(() {
                              _locationController.text =
                                  locationProvider.cityName;
                            });
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 11.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: ColorConstants.containerBorder),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.my_location, color: Colors.blue),
                              SizedBox(width: 10.w),
                              Text(
                                "Current location",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ]),
                  SizedBox(height: 18.h),
                  Text(
                    "Job date*",
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: _dateDropdown(
                          hint: 'Day',
                          value: selectedDay,
                          items: days,
                          onChanged: (value) =>
                              setState(() => selectedDay = value),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: _dateDropdown(
                          hint: 'Month',
                          value: selectedMonth,
                          items: months,
                          onChanged: (value) =>
                              setState(() => selectedMonth = value),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: _dateDropdown(
                          hint: 'Year',
                          value: selectedYear,
                          items: years,
                          onChanged: (value) =>
                              setState(() => selectedYear = value),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 18.h),
                  Text(
                    "Description*",
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  ElevatedButton(onPressed: logDate, child: Text("log")),
                  _textFields(
                    context,
                    double.infinity,
                    "Description",
                    100,
                    maxLines: 3,
                    _descriptionController,
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Required' : null,
                  ),
                  SizedBox(height: 18.h),
                  Text(
                    "Key responsiblities*",
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  _textFields(
                    context,
                    double.infinity,
                    "Responsiblities",
                    100,
                    maxLines: 3,
                    _key_responsibilities,
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Required' : null,
                  ),

                  SizedBox(height: 20.h),
                  GradientButton(
                    onPressed: () async {
                      String formatted =
                          '${selectedYear!}-${selectedMonth!.toString().padLeft(2, '0')}-${selectedDay!.toString().padLeft(2, '0')}';
                      bool formValid = _formKey.currentState!.validate();
                      bool selectionsValid = _validateSelections();
                      log(formatted.toString());
                      if (formValid && selectionsValid) {
                        // All fields are filled correctly — proceed with add job
                        await context.read<AddJobController>().onAddJob(
                              title: _jobTitleController.text,
                              description: _descriptionController.text,
                              job_date: formatted,
                              context: context,
                              job_image: _selectedImage,
                              salary_from: _salaryFromController.text,
                              salary_to: _salaryToController.text,
                              manual_location: _locationController.text,
                              key_responsibility: _key_responsibilities.text,
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
    bool isSelected = groupValue == value;
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
            color: hasError
                ? Colors.red
                : isSelected
                    ? Colors.blue
                    : ColorConstants.containerBorder,
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
    double height,
    TextEditingController controller, {
    VoidCallback? ontap,
    String? Function(String?)? validator,
    int? maxLines,
  }) {
    return SizedBox(
      width: width.w,
      height: height.h,
      child: TextFormField(
        validator: validator,
        controller: controller,
        maxLines: maxLines ?? 1,
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
            contentPadding:
                EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h)),
        onTap: ontap,
      ),
    );
  }
}

class LocationSearchDialog extends StatefulWidget {
  final Function(Map<String, dynamic>) onLocationSelected;

  const LocationSearchDialog({
    Key? key,
    required this.onLocationSelected,
  }) : super(key: key);

  @override
  _LocationSearchDialogState createState() => _LocationSearchDialogState();
}

class _LocationSearchDialogState extends State<LocationSearchDialog> {
  TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];
  Timer? _debounce;
  bool _isLoading = false;

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.isNotEmpty) {
        _searchLocation(query);
      } else {
        setState(() {
          _searchResults.clear();
          _isLoading = false;
        });
      }
    });
  }

  Future<void> _searchLocation(String query) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final url = Uri.parse(
        'https://nominatim.openstreetmap.org/search?q=$query&format=json&addressdetails=1&limit=10',
      );

      final response = await http.get(url, headers: {
        'User-Agent': 'FlutterLocationApp/1.0 (your_email@example.com)',
      });

      if (response.statusCode == 200) {
        final List results = json.decode(response.body);
        setState(() {
          _searchResults = results
              .map((e) => {
                    'display_name': e['display_name'],
                    'lat': e['lat'],
                    'lon': e['lon'],
                  })
              .toList();
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Search error: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Container(
        width: double.infinity,
        height: 500.h,
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Search Location',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(Icons.close),
                ),
              ],
            ),
            SizedBox(height: 16.h),

            // Search Field
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Enter location to search",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: ColorConstants.containerBorder),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: ColorConstants.containerBorder),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              onChanged: _onSearchChanged,
              onSubmitted: (query) {
                _debounce?.cancel();
                _searchLocation(query);
              },
            ),
            SizedBox(height: 16.h),

            // Results
            Expanded(
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : _searchResults.isEmpty
                      ? Center(
                          child: Text(
                            _searchController.text.isEmpty
                                ? 'Start typing to search locations'
                                : 'No results found',
                            style: TextStyle(
                              color: ColorConstants.descText,
                              fontSize: 14.sp,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: _searchResults.length,
                          itemBuilder: (context, index) {
                            final item = _searchResults[index];
                            return ListTile(
                              leading: Icon(
                                Icons.location_pin,
                                color: Colors.blue,
                              ),
                              title: Text(
                                item['display_name'],
                                style: TextStyle(fontSize: 14.sp),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: Text(
                                'Lat: ${item['lat']}, Lon: ${item['lon']}',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: ColorConstants.descText,
                                ),
                              ),
                              onTap: () => widget.onLocationSelected(item),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
