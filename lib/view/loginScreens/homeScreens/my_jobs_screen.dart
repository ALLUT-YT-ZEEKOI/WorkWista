import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:workwista/Utils/color_constants.dart';
import 'package:workwista/view/Controllers/jobs_screen_controller.dart';
import 'package:workwista/view/Model/my_jobs_model.dart';
import 'package:workwista/view/Model/posted_jobs_model.dart';
import 'package:workwista/view/Wdigets/gradient_button.dart';
import 'package:workwista/view/loginScreens/homeScreens/job_requests_screen.dart';
import 'package:workwista/view/loginScreens/homeScreens/payment_screen.dart';
import 'package:workwista/view/responsive_helper.dart';

class MyJobsScreen extends StatefulWidget {
  const MyJobsScreen({super.key});

  @override
  State<MyJobsScreen> createState() => _MyJobsScreenState();
}

class _MyJobsScreenState extends State<MyJobsScreen> {
  final PageController _pageController = PageController();
  final PageController _pageController2 = PageController();
  int _currentPage = 0;

  void _showNoRequestsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.blue),
              SizedBox(width: 10.w),
              Text("No Requests Yet"),
            ],
          ),
          content: Text(
            "This job hasn't received any applications yet. Check back later!",
            style: TextStyle(fontSize: 16.sp),
          ),
          actions: [
            TextButton(
              child: Text("OK", style: TextStyle(color: Colors.blue)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller =
          Provider.of<JobsScreenController>(context, listen: false);
      // STEP 1: Call both APIs to get all data
      controller.getMyJobs();
      controller.getPostedJobs(); // This was missing!
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<JobsScreenController>(
      builder: (context, controller, child) {
        // Combine all jobs for the page view
        final jobberJobs = controller.asJobberJobs;
        final recruiterJobs = controller.asRecruiterJobs;

        return Scaffold(
          appBar: AppBar(
            titleTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 28.sp,
                fontWeight: FontWeight.w700),
            title: Text("My jobs"),
            actions: [
              IconButton(
                  onPressed: () {
                    log("pressed");
                  },
                  icon: Icon(
                    Icons.settings,
                    size: 24,
                  ))
            ],
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 27.h),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 27.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // JOBBER JOBS PAGEVIEW
                    if (jobberJobs.isNotEmpty) ...[
                      Text("Jobs you are working on",
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black)),
                      SizedBox(height: 10.h),
                      SizedBox(
                        height: 230,
                        child: PageView(
                          controller: _pageController,
                          onPageChanged: (index) {
                            setState(() {
                              _currentPage = index;
                            });
                          },
                          children: jobberJobs
                              .map((job) => _buildJobCard(context, job))
                              .toList(),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Center(
                        child: SmoothPageIndicator(
                          controller: _pageController,
                          count: jobberJobs.length,
                          effect: WormEffect(
                            dotHeight: 3.h,
                            dotWidth: 19.w,
                            activeDotColor: ColorConstants.indicatorBlue,
                            dotColor: Color(0xffD9D9D9),
                          ),
                        ),
                      ),
                      SizedBox(height: 35.h),
                    ],

                    // RECRUITER JOBS PAGEVIEW
                    if (recruiterJobs.isNotEmpty) ...[
                      Text("Jobs you posted",
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black)),
                      SizedBox(height: 10.h),
                      SizedBox(
                        height: 230,
                        child: PageView.builder(
                          controller: _pageController2,
                          itemCount: recruiterJobs.length,
                          itemBuilder: (context, index) =>
                              _buildJobCard(context, recruiterJobs[index]),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Center(
                        child: SmoothPageIndicator(
                          controller: _pageController2,
                          count: recruiterJobs.length,
                          effect: WormEffect(
                            dotHeight: 3.h,
                            dotWidth: 19.w,
                            activeDotColor: ColorConstants.indicatorBlue,
                            dotColor: Color(0xffD9D9D9),
                          ),
                        ),
                      ),
                      SizedBox(height: 35.h),
                    ],

                    // POSTED JOBS LIST
                    Text(
                      "Posted Jobs",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 15.h),

                    // Convert the list into a scroll-friendly structure
                    Consumer<JobsScreenController>(
                      builder: (context, controller, _) {
                        final postedJobsListWidget =
                            _buildPostedJobsList(controller);

                        // If it's already a scrollable ListView, extract the children instead
                        if (controller.postedJobsList.isEmpty ||
                            controller.isloading) {
                          return postedJobsListWidget;
                        }

                        return ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller.postedJobsList.length,
                          separatorBuilder: (context, index) => Column(
                            children: [Divider(), SizedBox(height: 10.h)],
                          ),
                          itemBuilder: (context, index) {
                            final postedJob = controller.postedJobsList[index];
                            return InkWell(
                              onTap: () {
                                if ((postedJob.requestsCount ?? 0) > 0) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => JobRequestsScreen(
                                        jobId: postedJob.id!,
                                      ),
                                    ),
                                  ).then((_) {
                                    controller.getPostedJobs();
                                  });
                                } else {
                                  _showNoRequestsDialog(context);
                                }
                              },
                              child: _buildPostedJobsCard(postedJob),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildJobCard(BuildContext context, JobList job) {
    return Container(
      padding:
          EdgeInsets.only(right: 17.w, left: 14.w, top: 21.h, bottom: 19.h),
      width: 373.w,
      height: 230.h,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13.r),
          border:
              Border.all(color: ColorConstants.containerBorder, width: 1.w)),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.black,
                radius: 22.r,
                backgroundImage: NetworkImage(
                    "https://images.pexels.com/photos/974314/pexels-photo-974314.jpeg?auto=compress&cs=tinysrgb&w=600"),
              ),
              SizedBox(width: 14.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    job.jobTitle ?? "No Title",
                    style:
                        TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              Spacer(),
              Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 4.r,
                        backgroundColor: ColorConstants.nowOnline,
                      ),
                      SizedBox(width: 9.w),
                      Text(
                        "Online",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 24.h),
          Row(
            children: [
              Text(
                job.isCompleted ?? false ? "Completed" : "Ongoing",
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
              ),
              Spacer(),
            ],
          ),
          SizedBox(height: 14.h),
          Container(
            width: ResponsiveHelper.width(double.infinity, context),
            height: 7.h,
            decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.circular(23.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(23.r),
              child: LinearProgressIndicator(
                value: job.isCompleted ?? false ? 1.0 : 0.3,
                backgroundColor: Colors.transparent,
                valueColor: AlwaysStoppedAnimation<Color>(
                    ColorConstants.ProgressBarColor),
              ),
            ),
          ),
          SizedBox(height: 2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "9:00 AM",
                style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w500),
              ),
              Spacer(),
              Text(
                "6:00 PM",
                style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w500),
              ),
              Spacer(),
              Text(
                job.isPaid ?? false ? "Paid" : "Unpaid",
                style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(height: 13.h),
          InkWell(
            onTap: () {},
            child: GradientButton(
                radius: 10,
                onPressed: () {
                  if (!(job.isPaid ?? false)) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentScreen(),
                        ));
                  }
                },
                name: job.isUserJobber ?? false ? "Finish" : "Pay",
                height: 38.h,
                width: double.infinity.w),
          )
        ],
      ),
    );
  }

  // STEP 3: Fixed method - now takes controller directly and uses correct data
  Widget _buildPostedJobsList(JobsScreenController controller) {
    // Show loading only when loading and list is empty
    if (controller.isloading && controller.postedJobsList.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    // Check the correct list - postedJobsList
    if (controller.postedJobsList.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.work_off, size: 64, color: Colors.grey),
            SizedBox(height: 16.h),
            Text(
              "No posted jobs found",
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    // Build the list with the correct data
    return ListView.separated(
      itemCount: controller.postedJobsList.length, // Correct count
      separatorBuilder: (context, index) => Column(
        children: [Divider(), SizedBox(height: 10.h)],
      ),
      itemBuilder: (context, index) {
        final postedJob = controller.postedJobsList[index]; // Correct data
        return InkWell(
          onTap: () {
            if ((postedJob.requestsCount ?? 0) > 0) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => JobRequestsScreen(
                    jobId: postedJob.id!,
                  ),
                ),
              ).then((_) {
                controller.getPostedJobs();
              });
            } else {
              _showNoRequestsDialog(context);
            }
          },
          child: _buildPostedJobsCard(postedJob),
        );
      },
    );
  }

  // STEP 4: Fixed card styling - removed black background
  Widget _buildPostedJobsCard(PostedItem postedJob) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white, // Changed from black to white
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 21.r,
            backgroundColor: Colors.grey[300],
            backgroundImage: NetworkImage(
                "https://images.pexels.com/photos/974314/pexels-photo-974314.jpeg?auto=compress&cs=tinysrgb&w=600"),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  postedJob.title ?? "No Title",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black, // Ensure text is visible
                  ),
                ),
                SizedBox(height: 5.h),
                _infoItem("${postedJob.requestsCount ?? 0}", "Requests"),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, color: Colors.grey[600])
        ],
      ),
    );
  }

  Widget _infoItem(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
              fontSize: 12.sp,
              color: ColorConstants.greyText,
              fontWeight: FontWeight.w400),
        ),
        SizedBox(width: 2.w),
        Text(
          value,
          style: TextStyle(
              fontSize: 12.sp,
              color: ColorConstants.greyText,
              fontWeight: FontWeight.w400),
        ),
        SizedBox(width: 2.w),
        Text(
          "| kerala",
          style: TextStyle(
              fontSize: 12.sp,
              color: ColorConstants.greyText,
              fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
