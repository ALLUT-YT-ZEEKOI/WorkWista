import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:workwista/Utils/color_constants.dart';
import 'package:workwista/view/Controllers/apply_job_controller.dart';
import 'package:workwista/view/Controllers/job_details_screen_controller.dart';
import 'package:workwista/view/Wdigets/button_without_gradient.dart';
import 'package:workwista/view/Wdigets/gradient_button.dart';
import 'package:workwista/view/responsive_helper.dart';

// ignore: must_be_immutable
class JobDetailsScreen extends StatefulWidget {
  String? jobId;
  JobDetailsScreen({required this.jobId, super.key});

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await context
            .read<JobDetailsScreenController>()
            .getJobDetails(widget.jobId ?? "");
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String fixImageUrl(String? url) {
      if (url == null || url.isEmpty) return "";
      return url.replaceFirst("", "workwista.com");
      // log("last url: ${url}");
    }

    final controller = context.watch<JobDetailsScreenController>();

    final PageController _controller = PageController();
    final int _numPages = 1;

    // Show loading indicator
    if (controller.isloading) {
      return Center(child: CircularProgressIndicator());
    }

    // Show error if no data
    if (controller.jobDetails == null) {
      return Center(child: Text("Failed to load job details"));
    }
    final job = controller.jobDetails!.data;
    final imageUrl = (job?.jobImage != null && job!.jobImage!.isNotEmpty)
        ? 'https://workwista.com/${job.jobImage!.replaceFirst("file://", "").replaceFirst(RegExp(r"^/"), "")}'
        : 'https://images.pexels.com/photos/125532/pexels-photo-125532.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0, // remove shadow
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: InkWell(
          onTap: () {
            log(job!.manual_location.toString());
          },
          child: Text(
            "Job Details",
            style: TextStyle(
                color: Colors.black,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: Padding(
        padding:
            EdgeInsetsDirectional.symmetric(horizontal: 10.w, vertical: 18.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 203.h,
                child: PageView(
                  controller: _controller,
                  children: [
                    Container(
                      width: 373.w,
                      height: 203.h,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(imageUrl),
                          ),
                          borderRadius: BorderRadius.circular(11.r),
                          color: Colors.amber),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              Center(
                child: SmoothPageIndicator(
                  controller: _controller,
                  count: _numPages,
                  effect: WormEffect(
                    dotHeight: 3.h,
                    dotWidth: 19.w,
                    activeDotColor: ColorConstants.indicatorBlue,
                    dotColor: Color(0xffD9D9D9),
                  ),
                ),
              ),
              SizedBox(
                height: 37.h,
              ),
              Row(
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '₹',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 20.sp,
                            height: 1.0,
                            letterSpacing: 0.0,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: job?.salary_from != null
                              ? double.tryParse(job!.salary_from!)
                                      ?.toInt()
                                      .toString() ??
                                  "0"
                              : "Salary not specified",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 24.sp,
                            height: 1.0,
                            letterSpacing: 0.0,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: ' - ',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 20.sp,
                            height: 1.0,
                            letterSpacing: 0.0,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: job?.salary_to != null
                              ? double.tryParse(job!.salary_to!)
                                      ?.toInt()
                                      .toString() ??
                                  "0"
                              : "Salary not specified",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 24.sp,
                            height: 1.0,
                            letterSpacing: 0.0,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: '/',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20.sp,
                            height: 1.0,
                            letterSpacing: 0.0,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: 'month',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                            height: 1.5,
                            letterSpacing: 0.0,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.bookmark_border_outlined,
                    size: 24,
                  )
                ],
              ),
              Text(
                "1 vacancy for Sales Staff",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 16.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 0.w),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 0),
                          height: 32.h,
                          // width: 121.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                width: 1.w,
                                color: Color(0xff7991A4),
                              )),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Baseline(
                                baselineType: TextBaseline.alphabetic,
                                baseline: 16.sp,
                                child: Image.asset(
                                  'assets/location2.png',
                                  width: 18.w,
                                  height: 18.h,
                                  alignment: Alignment.center,
                                ),
                              ),
                              SizedBox(
                                width: 6.w,
                              ),
                              Align(
                                child: Text(
                                  job?.manual_location
                                          ?.split(',')
                                          .first
                                          .trim() ??
                                      "N/A",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                      color: ColorConstants.lighttext),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 0),
                          height: 32.h,
                          // width: 121.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                width: 1.w,
                                color: Color(0xff7991A4),
                              )),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Baseline(
                                baselineType: TextBaseline.alphabetic,
                                baseline: 16.sp,
                                child: Image.asset(
                                  'assets/building.png',
                                  width: 18.w,
                                  height: 18.h,
                                  alignment: Alignment.center,
                                ),
                              ),
                              SizedBox(
                                width: 6.w,
                              ),
                              Align(
                                child: Text(
                                  "Lulu Hypermarket",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                      color: ColorConstants.ProgressBarColor),
                                ),
                              ),
                              SizedBox(
                                width: 4.w,
                              ),
                              Baseline(
                                baselineType: TextBaseline.alphabetic,
                                baseline: 9.sp,
                                child: Image.asset(
                                  'assets/north_east.png',
                                  width: 10.w,
                                  height: 10.h,
                                  alignment: Alignment.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                      SizedBox(
                        height: 8.h,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12.w, vertical: 0),
                        height: 32.h,
                        // width: 121.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              width: 1.w,
                              color: Color(0xff7991A4),
                            )),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Baseline(
                              baselineType: TextBaseline.alphabetic,
                              baseline: 16.sp,
                              child: Image.asset(
                                'assets/flag_black.png',
                                width: 18.w,
                                height: 18.h,
                                alignment: Alignment.center,
                              ),
                            ),
                            SizedBox(
                              width: 6.w,
                            ),
                            Align(
                              child: Text(
                                job?.jobType ?? "Type not specified",
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    color: ColorConstants.lighttext),
                              ),
                            )
                          ],
                        ),
                      ),
                    ]),
              ),
              SizedBox(
                height: 25.h,
              ),
              Text(
                "Job description",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 8.h,
              ),
              Text(
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                job?.description ?? "Description not specified",
                style: TextStyle(
                    color: ColorConstants.descText,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Key Responsbilities",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8.h),

// Constrain the height to approximate 4 lines of text
              ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: 100
                      .h, // Adjust this value based on your font size & line height
                ),
                child: Text(
                  job?.key_responsibility?.isNotEmpty == true
                      ? job!.key_responsibility!
                      : "Not specified",
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: ColorConstants.descText,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              GradientButton(
                onPressed: () async {
                  await context.read<ApplyJobController>().onApplyJob(
                        context: context,
                        Jobid: job?.id ?? "id not found",
                      );
                },
                name: "Apply job",
                width: 373.w,
                height: 44.h,
              ),
              SizedBox(
                height: 4.h,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: ButtonWithoutGradient(
                  name: "Back",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container skillsContainer(BuildContext context, String skillText) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.width(12, context),
      ),
      height: ResponsiveHelper.height(36, context),
      constraints: BoxConstraints(
        maxWidth:
            ResponsiveHelper.width(180, context), // Add max width constraint
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(27),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            // Or use Expanded if you want to force maximum available space
            child: Text(
              skillText,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
