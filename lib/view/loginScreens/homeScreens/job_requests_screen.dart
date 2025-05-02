import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workwista/Utils/color_constants.dart';
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

        if (controller.jobRequests?.data == null ||
            controller.jobRequests!.data!.isEmpty) {
          return Center(
            child: Container(
              width: ResponsiveHelper.width(372, context),
              height: ResponsiveHelper.height(200, context),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: ColorConstants.descText),
                borderRadius: BorderRadius.circular(14),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.work_outline,
                    size: 40,
                    color: Colors.grey[400],
                  ),
                  SizedBox(height: 16),
                  Text(
                    "No requests found",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: ResponsiveHelper.width(40, context),
                    ),
                    child: Text(
                      "When someone applies to your posted job, their request will appear here",
                      style: TextStyle(
                        color: ColorConstants.descText,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Requests",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: ResponsiveHelper.width(14, context),
                vertical: ResponsiveHelper.height(14, context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 35,
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: controller.jobRequests!.data!.length,
                    separatorBuilder: (context, index) => SizedBox(height: 20),
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
          height: ResponsiveHelper.height(104, context),
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 17.5,
                    backgroundColor: Colors.black,
                  ),
                  SizedBox(width: ResponsiveHelper.width(9, context)),
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
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'requested to your job role',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            CircleAvatar(
                              radius: 5,
                              backgroundColor: ColorConstants.dotBlue,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              overflow: TextOverflow.fade,
                              "Date ${request.requesteDate?.toString() ?? 'unknown date'}",
                              style: TextStyle(
                                color: ColorConstants.descText,
                                fontSize: 14,
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
              SizedBox(height: 24),
             Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    // Decline button
    _buildActionButton(
      text: "Decline",
      color: Colors.white,
      textColor: Colors.black,
      onPressed: () async {
        final controller = Provider.of<JobsScreenController>(
          context, 
          listen: false,
        );
        await controller.respondToRequest(request.id!, "decline");
        Navigator.pop(context); // Go back to MyJobsScreen
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
        Navigator.pop(context); // Go back to MyJobsScreen
      },
    ),
  ],
),

          ],
        ),
      ),
        SizedBox(height: 20),
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
      height: 32,
      width: ResponsiveHelper.width(170, context),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
