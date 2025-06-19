import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:workwista/Utils/color_constants.dart';
import 'package:workwista/view/Common%20Screens/custom_bottom_navbar.dart';
import 'package:workwista/view/Controllers/jobs_screen_controller.dart';
import 'package:workwista/view/Model/job_requests_model.dart';

import 'package:workwista/view/responsive_helper.dart';

class JobRequestsScreen extends StatefulWidget {
  final String jobId;
  final int? reqCount;
  final String jobTitle;
  final String salary_from;
  final String salary_to;
  final DateTime? jobdate;
  final bool? is_closed_job;
  const JobRequestsScreen(
      {super.key,
      required this.reqCount,
      required this.salary_from,
      required this.salary_to,
      required this.jobdate,
      required this.jobTitle,
      required this.jobId,
      required this.is_closed_job});

  @override
  State<JobRequestsScreen> createState() => _JobRequestsScreenState();
}

class _JobRequestsScreenState extends State<JobRequestsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller =
          Provider.of<JobsScreenController>(context, listen: false);
      controller.getJobRequests(widget.jobId); // Pass the jobId from widget
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<JobsScreenController>(
      builder: (context, controller, child) {
        if (controller.isloading && controller.jobRequests == null) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage != null) {
          return Center(
            child: Text(
              controller.errorMessage!,
              style: TextStyle(
                fontSize: 16,
                color: Colors.red[600],
              ),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false, // disable default back button
            title: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "View job",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      "${widget.reqCount} Request",
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: ColorConstants.reqCountColor),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Transform.translate(
                    offset: Offset(-12, 0), // Move 12 pixels to the left
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  height: 240.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13.r),
                      border: Border.all(width: 1.w, color: Color(0xff8FC1FF))),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 22.5.r,
                            backgroundColor: Colors.white,
                            backgroundImage: NetworkImage(
                                'https://images.pexels.com/photos/2586823/pexels-photo-2586823.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
                          ),
                          SizedBox(
                            width: 9.w,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.jobTitle,
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      color: Color(0xff92A5B5),
                                      "assets/location2.png",
                                      scale: 1.2,
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    Text(
                                      "location",
                                      style: TextStyle(
                                          color: Color(0xff92A5B5),
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          Spacer(),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    widget.salary_from,
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    " - ${widget.salary_to}",
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              Text(
                                widget.jobdate != null
                                    ? DateFormat('yyyy-MM-dd')
                                        .format(widget.jobdate!)
                                    : "No date",
                                style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text.rich(
                        TextSpan(
                          text: "Become a vital part of our skilled carpentry team as a Carpenter! "
                                      "In this position, you'll craft beautiful wooden structures, collaborate "
                                      "with clients to understand their vision, "
                                  .substring(0, 100) +
                              "... ",
                          style: TextStyle(
                              color: Color(0xff92A5B5),
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                          children: [
                            TextSpan(
                              text: "more",
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w500,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // Handle "more" tap if needed
                                },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 23.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () async {
                              if (widget.is_closed_job == true) {
                                await showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    backgroundColor: const Color(0xffffffff),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    title: const Text("Alert"),
                                    content:
                                        const Text("Job is already closed."),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(ctx),
                                        child: const Text("OK"),
                                      ),
                                    ],
                                  ),
                                );
                                return;
                              }

                              final bool? confirm = await showDialog<bool>(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  backgroundColor: Color(0xffffffff),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(12.r)),
                                  title: Text("Close job?"),
                                  content: Text(
                                    'This will permanently close the job. '
                                    'Are you sure you want to continue?',
                                  ),
                                  actionsPadding: EdgeInsets.symmetric(
                                      horizontal: 16.w, vertical: 8.h),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(ctx, false), //cancel

                                      child: Text("Cancel"),
                                    ),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Color(0xffE4626F),
                                        ),
                                        onPressed: () =>
                                            Navigator.pop(ctx, true), //confirm

                                        child: Text(
                                          "Close",
                                          style: TextStyle(color: Colors.white),
                                        ))
                                  ],
                                ),
                              );
                              if (confirm == true) {
                                final controller =
                                    Provider.of<JobsScreenController>(context,
                                        listen: false);

                                final success =
                                    await controller.closeJob(widget.jobId);

                                if (success) {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => CustomBottomNavbar(
                                                successMessage:
                                                    "Job closed Successfully",
                                              )),
                                      (Route<dynamic> route) => false);
                                }
                              }
                            },
                            child: Container(
                              height: 40,
                              width: 149,
                              decoration: BoxDecoration(
                                  color: Color(0xffDAEAFF),
                                  borderRadius: BorderRadius.circular(12.r)),
                              child: Center(
                                child: Text(
                                  widget.is_closed_job == true
                                      ? "Closed"
                                      : "Close job ",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff1E83FF)),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              final bool? confirm = await showDialog<bool>(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  backgroundColor: Color(0xffffffff),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  title: const Text('Delete job?'),
                                  content: const Text(
                                    'This will permanently remove the job. '
                                    'Are you sure you want to continue?',
                                  ),
                                  actionsPadding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(ctx, false), // cancel
                                      child: const Text('Cancel'),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xffE4626F),
                                      ),
                                      onPressed: () =>
                                          Navigator.pop(ctx, true), // confirm
                                      child: const Text(
                                        'Delete',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              );

                              if (confirm == true) {
                                final controller =
                                    Provider.of<JobsScreenController>(
                                  context,
                                  listen: false,
                                );

                                final success =
                                    await controller.deleteJob(widget.jobId);

                                if (success) {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => CustomBottomNavbar(
                                              successMessage:
                                                  "Job Deleted Successfully",
                                            )),
                                    (Route<dynamic> route) => false,
                                  );
                                } else {
                                  await showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      backgroundColor: Color(0xffffffff),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                      ),
                                      title: Text("Warning"),
                                      content: Text(
                                          "Job cannot be deleted. Close it first if it is ongoing."),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(ctx),
                                          child: Text("OK"),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              }
                            },
                            child: Container(
                              height: 40,
                              width: 149,
                              decoration: BoxDecoration(
                                color: const Color(0xffE4626F),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Center(
                                child: Text(
                                  'Delete Job',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xffFFFFFF),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                Text(
                  "Requests",
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 12.h,
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: controller.jobRequests!.data!.length,
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 30.h),
                    itemBuilder: (context, index) {
                      final request = controller.jobRequests!.data![index];
                      return _buildRequestCard(request);
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRequestCard(RequestData request) {
    return Column(
      children: [
        Container(
          height: 105.h,
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 17.5.r,
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(
                        scale: 0.2,
                        'https://images.pexels.com/photos/32270249/pexels-photo-32270249/free-photo-of-portrait-of-a-thoughtful-young-man-in-black.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
                  ),
                  SizedBox(width: 9.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text.rich(
                                TextSpan(
                                  text: '${request.applicantName} ',
                                  style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'requested to your job role',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            CircleAvatar(
                              radius: 3.5.r,
                              backgroundColor: ColorConstants.dotBlue,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              overflow: TextOverflow.ellipsis,
                              request.requesteDate != null
                                  ? DateFormat('dd MMM yyyy, hh:mm a').format(
                                      DateTime.parse(
                                          request.requesteDate.toString()))
                                  : 'Unknown date',
                              style: TextStyle(
                                color: ColorConstants.descText,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Spacer(),
                            // Text(
                            //   "ID: ${request.applicantId?.toStringAsFixed(0) ?? 'N/A'}",
                            //   style: TextStyle(
                            //     fontSize: 12,
                            //     fontWeight: FontWeight.w500,
                            //     color: ColorConstants.descText,
                            //   ),
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Decline button
                  _buildActionButton(
                    text: "Decline",
                    color: ColorConstants.declineBtn,
                    textColor: Colors.black,
                    onPressed: () async {
                      final controller = Provider.of<JobsScreenController>(
                        context,
                        listen: false,
                      );
                      await controller.respondToRequest(request.id!, "decline");
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CustomBottomNavbar(),
                          )); // Go back to MyJobsScreen
                    },
                  ),
                  SizedBox(width: ResponsiveHelper.width(16, context)),
                  // Accept button
                  _buildActionButton(
                    text: "Accept",
                    color: ColorConstants.dotBlue,
                    textColor: Colors.white,
                    onPressed: () async {
                      final controller = Provider.of<JobsScreenController>(
                        context,
                        listen: false,
                      );
                      await controller.respondToRequest(request.id!, "accept");
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CustomBottomNavbar(),
                          )); // Go back to MyJobsScreen
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 15.h),
        Divider(
          height: 1,
          thickness: 1,
          color: Colors.grey[300],
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required String text,
    required Color color,
    required Color textColor,
    required VoidCallback onPressed,
  }) {
    return Container(
      height: 39.h,
      width: 175.w,
      decoration: BoxDecoration(
        border: Border.all(width: 1.w, color: Color(0xffD3D3D3)),
        color: color,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w500,
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }
}
