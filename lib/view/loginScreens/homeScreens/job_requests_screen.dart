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
  const JobRequestsScreen({super.key, required this.jobId});

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

        // if (controller.jobRequests?.data == null ||
        //     controller.jobRequests!.data!.isEmpty) {
        //   return Center(
        //     child: Container(
        //       width: ResponsiveHelper.width(372, context),
        //       height: ResponsiveHelper.height(200, context),
        //       decoration: BoxDecoration(
        //         border: Border.all(width: 1, color: ColorConstants.descText),
        //         borderRadius: BorderRadius.circular(14),
        //         color: Colors.white,
        //       ),
        //       child: Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           Icon(
        //             Icons.work_outline,
        //             size: 40,
        //             color: Colors.grey[400],
        //           ),
        //           SizedBox(height: 16),
        //           Text(
        //             "No requests found",
        //             style: TextStyle(
        //               color: Colors.black,
        //               fontSize: 18,
        //               fontWeight: FontWeight.w500,
        //             ),
        //           ),
        //           SizedBox(height: 8),
        //           Padding(
        //             padding: EdgeInsets.symmetric(
        //               horizontal: ResponsiveHelper.width(40, context),
        //             ),
        //             child: Text(
        //               "When someone applies to your posted job, their request will appear here",
        //               style: TextStyle(
        //                 color: ColorConstants.descText,
        //                 fontSize: 14,
        //                 fontWeight: FontWeight.w400,
        //               ),
        //               textAlign: TextAlign.center,
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   );
        // }

        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Job Requests",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w700),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
