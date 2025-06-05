import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:workwista/Utils/color_constants.dart';
import 'package:workwista/view/Controllers/jobs_screen_controller.dart';
import 'package:workwista/view/Model/job_completion_model.dart';
import 'package:workwista/view/Model/my_jobs_model.dart';
import 'package:workwista/view/Model/posted_jobs_model.dart';
import 'package:workwista/view/Wdigets/gradient_button.dart';
import 'package:workwista/view/loginScreens/homeScreens/job_requests_screen.dart';
import 'package:workwista/view/loginScreens/homeScreens/payment_screen.dart';
import 'package:workwista/view/responsive_helper.dart';

class JobStatusScreen extends StatefulWidget {
  const JobStatusScreen({super.key});

  @override
  State<JobStatusScreen> createState() => _JobStatusScreenState();
}

class _JobStatusScreenState extends State<JobStatusScreen> {
  final PageController _pageController = PageController();
  final PageController _pageController2 = PageController();
  int _currentPage = 0;
  final DateTime currentdate = DateTime.now();
  DateTime JobDate = DateTime(2025, 05, 29);

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

// In _MyJobsScreenState class
  bool _isJobStarted() {
    return DateTime.now().isAfter(JobDate);
  }

  String _getJobStatusText(JobList job) {
    if (!_isJobStarted()) return "Not Started";
    if (job.isCompleted ?? false) return "Completed";
    return "Ongoing";
  }

  Color _getJobStatusColor(JobList job) {
    if (!_isJobStarted()) return Colors.grey;
    if (job.isCompleted ?? false) return Colors.green;
    return Colors.orange;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<JobsScreenController>(
      builder: (context, controller, child) {
        // Combine all jobs for the page view
        final jobberJobs = controller.asJobberJobs;
        final recruiterJobs = controller.asRecruiterJobs;
        final completedJobData = controller.completedJobData;
        return Scaffold(
          appBar: AppBar(
            titleTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 28.sp,
                fontWeight: FontWeight.w700),
            title: InkWell(
                onTap: () {
                  final String formattedJDate =
                      DateFormat('yyyy-MM-dd').format(JobDate);
                  log("formatted jobdate :${formattedJDate}");
                  final String formattedCDate =
                      DateFormat('yyyy-MM-dd').format(currentdate);
                  log("formatted current date :${formattedCDate}");
                },
                child: Text("Job status")),
            actions: [],
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 0.h),
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
                    // COMPLETED JOB SECTION
                    if (completedJobData != null &&
                        completedJobData.isUserJobber == true) ...[
                      InkWell(
                        onTap: () {
                          log(completedJobData.isUserJobber.toString());
                        },
                        child: Text("Completed Jobs",
                            style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black)),
                      ),
                      SizedBox(height: 10.h),
                      _buildCompletedJobCard(context, completedJobData),
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => JobRequestsScreen(
                                      salary_from:
                                          postedJob.salary_from ?? "not found",
                                      salary_to:
                                          postedJob.salary_to ?? "not founf",
                                      jobdate: postedJob.jobDate,
                                      jobTitle: postedJob.title ?? "not found",
                                      reqCount: postedJob.requestsCount,
                                      jobId: postedJob.id!,
                                      is_closed_job: postedJob.is_closed_job,
                                    ),
                                  ),
                                ).then((_) {
                                  controller.getPostedJobs();
                                });
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

  Widget _buildCompletedJobCard(
      BuildContext context, CompletedJobData completedJob) {
    log(completedJob.id.toString());
    return Container(
      padding:
          EdgeInsets.only(right: 17.w, left: 14.w, top: 21.h, bottom: 19.h),
      width: 373.w,
      height: 230.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13.r),
        border: Border.all(color: ColorConstants.containerBorder, width: 1.w),
      ),
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
                    completedJob.job!.title ?? "No Title",
                    style:
                        TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    completedJob.isUserJobber ?? false
                        ? "Recruiter: ${completedJob.job!.jobRecruter ?? 'Unknown'}"
                        : "Worker: ${completedJob.jobberName ?? 'Unknown'}",
                    style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w300,
                        color: Colors.grey[600]),
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
                completedJob.isCompleted ?? false ? "Completed" : "Ongoing",
                style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: completedJob.isCompleted ?? false
                        ? Colors.green
                        : Colors.orange),
              ),
              Spacer(),
              if (completedJob.isCompleted ?? false)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: completedJob.isPaid ?? false
                        // ignore: deprecated_member_use
                        ? Colors.green.withOpacity(0.1)
                        // ignore: deprecated_member_use
                        : Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: completedJob.isPaid ?? false
                          ? Colors.green
                          : Colors.orange,
                      width: 1,
                    ),
                  ),
                  child: Text(
                    completedJob.isPaid ?? false ? "Paid" : "Payment Pending",
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                      color: completedJob.isPaid ?? false
                          ? Colors.green
                          : Colors.orange,
                    ),
                  ),
                ),
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
                value: 1.0, // Completed job = 100%
                backgroundColor: Colors.transparent,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
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
                completedJob.isPaid ?? false ? "Paid" : "Unpaid",
                style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                    color: completedJob.isPaid ?? false
                        ? Colors.green
                        : Colors.red),
              ),
            ],
          ),
          SizedBox(height: 13.h),
          GradientButton(
            radius: 10,
            onPressed: null, // Completed jobs don't need action buttons
            name: completedJob.isPaid ?? false ? "Paid" : "Waiting for Payment",
            height: 38.h,
            width: double.infinity.w,
          ),
        ],
      ),
    );
  }

  Widget _buildJobCard(BuildContext context, JobList jobList) {
    return Consumer<JobsScreenController>(
      builder: (context, controller, child) {
        return Container(
          padding:
              EdgeInsets.only(right: 17.w, left: 14.w, top: 21.h, bottom: 19.h),
          width: 373.w,
          height: 230.h,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(13.r),
              border: Border.all(
                  color: ColorConstants.containerBorder, width: 1.w)),
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
                        jobList.job!.title ?? "No Title",
                        style: TextStyle(
                            fontSize: 12.sp, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        jobList.isUserJobber ?? false
                            ? "Recruiter: ${jobList.job!.job_recruter ?? 'Unknown'}"
                            : "Worker: ${jobList.jobberName ?? 'Unknown'}",
                        style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w300,
                            color: Colors.grey[600]),
                      ),
                      SizedBox(height: 4.h),
                     
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
                    jobList.isCompleted ?? false ? "Completed" : "Ongoing",
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: jobList.isCompleted ?? false
                            ? Colors.green
                            : Colors.orange),
                  ),
                  Spacer(),
                  if (jobList.isCompleted ?? false)
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: jobList.isPaid ?? false
                            // ignore: deprecated_member_use
                            ? Colors.green.withOpacity(0.1)
                            // ignore: deprecated_member_use
                            : Colors.orange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                          color: jobList.isPaid ?? false
                              ? Colors.green
                              : Colors.orange,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        jobList.isPaid ?? false ? "Paid" : "Payment Pending",
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                          color: jobList.isPaid ?? false
                              ? Colors.green
                              : Colors.orange,
                        ),
                      ),
                    ),
                ],
              ),
             
            
              SizedBox(height: 2.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "9:00 AM",
                    style:
                        TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w500),
                  ),
                  Spacer(),
                  Text(
                    "6:00 PM",
                    style:
                        TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w500),
                  ),
                  Spacer(),
                  Text(
                    jobList.isPaid ?? false ? "Paid" : "Unpaid",
                    style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                        color: jobList.isPaid ?? false
                            ? Colors.green
                            : Colors.red),
                  ),
                ],
              ),
              SizedBox(height: 13.h),
              controller.isCompletingJob
                  ? Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            ColorConstants.ProgressBarColor),
                      ),
                    )
                  : GradientButton(
                      radius: 10,
                      onPressed: controller.isJobButtonEnabled(jobList)
                          ? () async {
                              await _handleJobAction(
                                  context, jobList, controller);
                            }
                          : null,
                      name: controller.getJobButtonText(jobList),
                      height: 38.h,
                      width: double.infinity.w,
                    ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _handleJobAction(BuildContext context, JobList jobList,
      JobsScreenController controller) async {
    if (jobList.isUserJobber ?? false) {
      // User is jobber - handle finish job
      if (!(jobList.isCompleted ?? false)) {
        // Directly complete the job without confirmation
        final success = await controller.completeJob(jobList.id);
        log(jobList.job?.id.toString() ?? "");
        if (success && mounted) {
          // Show success snackbar
          _showSnackBar(context, "Job completed successfully!", false);
        } else if (mounted) {
          // Show error snackbar
          _showSnackBar(context,
              controller.errorMessage ?? "Failed to complete job", true);
        }
      }
    } else {
      // User is recruiter - handle payment (unchanged)
      if ((jobList.isCompleted ?? false) && !(jobList.isPaid ?? false)) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentScreen(),
          ),
        );
      }
    }
  }

  void _showSnackBar(BuildContext context, String message, bool isError) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  // STEP 3:  - now takes controller directly and uses correct data
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
           
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => JobRequestsScreen(
                    salary_from: postedJob.salary_from ?? "not found",
                    salary_to: postedJob.salary_to ?? "not found",
                    jobTitle: postedJob.title ?? "not found",
                    jobdate: postedJob.jobDate,
                    reqCount: postedJob.requestsCount,
                    jobId: postedJob.id!,
                    is_closed_job: postedJob.is_closed_job,
                  ),
                ),
              ).then((_) {
                controller.getPostedJobs();
              });
         
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
