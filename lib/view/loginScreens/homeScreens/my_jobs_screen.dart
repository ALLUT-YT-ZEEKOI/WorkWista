import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workwista/Utils/color_constants.dart';

import 'package:workwista/view/Controllers/jobs_screen_controller.dart';
import 'package:workwista/view/Model/posted_jobs_model.dart';

import 'package:workwista/view/Wdigets/gradient_button.dart';
import 'package:workwista/view/loginScreens/homeScreens/job_requests_screen.dart';

import 'package:workwista/view/responsive_helper.dart';

class MyJobsScreen extends StatefulWidget {
  const MyJobsScreen({super.key});

  @override
  State<MyJobsScreen> createState() => _MyJobsScreenState();
}

class _MyJobsScreenState extends State<MyJobsScreen> {
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
              SizedBox(width: 10),
              Text("No Requests Yet"),
            ],
          ),
          content: Text(
            "This job hasn't received any applications yet. Check back later!",
            style: TextStyle(fontSize: 16),
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

  bool showCurrentJobCard = true;

  @override
  void initState() {
    super.initState();
    // Fetch posted jobs when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<JobsScreenController>(context, listen: false).getPostedJobs();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<JobsScreenController>(
      builder: (context, controller, child) {
        return DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              titleTextStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w700),
              title: const Text("My jobs"),
              actions: [
                IconButton(
                    onPressed: () {
                      log("pressed");
                    },
                    icon: const Icon(
                      Icons.more_vert,
                      size: 26,
                    ))
              ],
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveHelper.width(14, context),
                  vertical: ResponsiveHelper.height(14, context)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Your existing profile card
                  if (showCurrentJobCard)
                    Container(
                      padding: EdgeInsets.only(
                          right: ResponsiveHelper.width(16, context),
                          left: ResponsiveHelper.width(17, context),
                          top: ResponsiveHelper.height(21, context),
                          bottom: ResponsiveHelper.height(19, context)),
                      width: ResponsiveHelper.width(373, context),
                      height: 240,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(13),
                          border: Border.all(
                              color: ColorConstants.containerBorder, width: 1)),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const CircleAvatar(
                                backgroundColor: Colors.black,
                                radius: 24,
                              ),
                              SizedBox(
                                width: ResponsiveHelper.width(14, context),
                              ),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Joseph",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "plumbing Work",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 4,
                                        backgroundColor:
                                            ColorConstants.nowOnline,
                                      ),
                                      SizedBox(
                                        width:
                                            ResponsiveHelper.width(9, context),
                                      ),
                                      const Text(
                                        "Online",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                  const Text(
                                    "06/09/2025",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 23,
                          ),
                          const Row(
                            children: [
                              Text(
                                "Ongoing",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w500),
                              ),
                              Spacer(),
                              Text(
                                "Owner",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          Container(
                            width: ResponsiveHelper.width(
                                double.infinity, context),
                            height: 8,
                            decoration: BoxDecoration(
                              color: Colors.blue[100],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: LinearProgressIndicator(
                                value: 0.1,
                                backgroundColor: Colors.transparent,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    ColorConstants.ProgressBarColor),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "9:00 AM",
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.w500),
                              ),
                              Spacer(),
                              Text(
                                "6:00 PM",
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.w500),
                              ),
                              Spacer(),
                              Text(
                                "pay",
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {},
                            child: GradientButton(
                                onPressed: () {
                                  log("showing payment window");
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20)),
                                    ),
                                    backgroundColor: Colors.white,
                                    builder: (context) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                            bottom: MediaQuery.of(context)
                                                .viewInsets
                                                .bottom),
                                        child: Container(
                                          height: ResponsiveHelper.height(
                                              270, context),
                                          padding: const EdgeInsets.all(16),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                width: 40,
                                                height: 4,
                                                decoration: BoxDecoration(
                                                  color: Colors.black26,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                              const SizedBox(height: 16),
                                              // Payment Icons Row
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  CircleAvatar(
                                                      radius: 25,
                                                      backgroundColor:
                                                          ColorConstants
                                                              .indicatorBlue,
                                                      child: CircleAvatar(
                                                        backgroundColor:
                                                            Colors.white,
                                                        radius: 24,
                                                        child: Image.asset(
                                                            "assets/upi.png"),
                                                      )),
                                                  CircleAvatar(
                                                      radius: 25,
                                                      backgroundColor:
                                                          ColorConstants
                                                              .indicatorBlue,
                                                      child: CircleAvatar(
                                                        backgroundColor:
                                                            Colors.white,
                                                        radius: 24,
                                                        child: Image.asset(
                                                            "assets/gpay.png"),
                                                      )),
                                                  CircleAvatar(
                                                      radius: 25,
                                                      backgroundColor:
                                                          ColorConstants
                                                              .indicatorBlue,
                                                      child: CircleAvatar(
                                                        backgroundColor:
                                                            ColorConstants
                                                                .phonepe,
                                                        radius: 24,
                                                        child: Image.asset(
                                                            "assets/phonepe.png"),
                                                      )),
                                                  CircleAvatar(
                                                      radius: 25,
                                                      backgroundColor:
                                                          ColorConstants
                                                              .indicatorBlue,
                                                      child: CircleAvatar(
                                                        backgroundColor:
                                                            Colors.white,
                                                        radius: 24,
                                                        child: Image.asset(
                                                            "assets/paytm.png"),
                                                      )),
                                                  CircleAvatar(
                                                      radius: 25,
                                                      backgroundColor:
                                                          ColorConstants
                                                              .indicatorBlue,
                                                      child: CircleAvatar(
                                                        backgroundColor:
                                                            Colors.white,
                                                        radius: 24,
                                                        child: Image.asset(
                                                            "assets/bank.png"),
                                                      )),
                                                ],
                                              ),
                                              const SizedBox(height: 20),
                                              // TextField for UPI ID
                                              SizedBox(
                                                height: ResponsiveHelper.height(
                                                    50, context),
                                                child: TextFormField(
                                                  decoration: InputDecoration(
                                                    hintText: "Enter upi id",
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0),
                                                      borderSide: BorderSide(
                                                        color: ColorConstants
                                                            .containerBorder
                                                            .withOpacity(0.1),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 20),
                                              // Next Button
                                              GradientButton(
                                                  name: "Next",
                                                  onPressed: () {
                                                    log("add payment logic");
                                                  },
                                                  height: 45,
                                                  width: ResponsiveHelper.width(
                                                      double.infinity, context))
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                name: "Pay",
                                height: 38,
                                width: ResponsiveHelper.width(
                                    double.infinity, context)),
                          )
                        ],
                      ),
                    ),
                  const SizedBox(
                    height: 0,
                  ),
                  // Container(
                  //   height: 70,
                  //   color: Colors.white,
                  //   child: TabBar(
                  //     indicator: BoxDecoration(
                  //       color: Colors.grey[200],
                  //     ),
                  //     labelColor: Colors.black,
                  //     unselectedLabelColor: Colors.black54,
                  //     indicatorSize: TabBarIndicatorSize.tab,
                  //     dividerColor: Colors.transparent,
                  //     tabs: const [
                  //       TabItem(title: "Recent", count: "17"),
                  //       TabItem(title: "Posted", count: "5"),
                  //       TabItem(title: "Done", count: "7"),
                  //     ],
                  //   ),
                  // ),
                  // Expanded(
                  //   child: TabBarView(
                  //     children: [
                  //       // Recent Tab
                  //       _buildJobList(controller.jobsList),
                  //       // Posted Tab (filter as needed)

                  //       _buildJobList(controller.jobsList),

                  //       // Done Tab (filter as needed)

                  //       _buildJobList(controller.jobsList),
                  //     ],
                  //   ),
                  // ),

                  Text(
                    "Posted Jobs",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Expanded(
                    child: Consumer<JobsScreenController>(
                      builder: (context, controller, child) {
                        if (controller.isloading &&
                            controller.postedJobsList.isEmpty) {
                          return Center(child: CircularProgressIndicator());
                        }

                        if (controller.postedJobsList.isEmpty) {
                          return Center(child: Text("No posted jobs found"));
                        }

                        return ListView.separated(
                          itemCount: controller.postedJobsList.length,
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 20),
                          itemBuilder: (context, index) {
                            final postedJob = controller.postedJobsList[index];
                            return InkWell(
                              onTap: () {
                                if (postedJob.id != null) {
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
                                }
                              },
                              child: _buildPostedJobsCard(postedJob),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPostedJobsCard(PostedItem postedJob) {
    // Now takes the job directly
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            postedJob.title ?? "No Title",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),

          // Row 1: Requests & Salary
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _infoItem("Requests", "${postedJob.requestsCount ?? 0}"),
              _infoItem("Salary", postedJob.salary ?? "Not specified"),
            ],
          ),
          SizedBox(height: 8),

          // Row 2: Job Type & Category
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [],
          ),
          SizedBox(height: 8),

          // Row 3: Job Date
          Row(
            children: [
              _infoItem(
                  "Date",
                  postedJob.jobDate != null
                      ? "${postedJob.jobDate!.day}/${postedJob.jobDate!.month}/${postedJob.jobDate!.year}"
                      : "Not specified"),
            ],
          ),
        ],
      ),
    );
  }

// Inline widget for info items
  Widget _infoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
        SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

//   Widget _buildJobList(List<JobItem> jobs) {
//     if (jobs.isEmpty) {
//       return const Center(child: Text("No jobs found"));
//     }

//     return SingleChildScrollView(
//       child: Column(
//         children: jobs.map((job) => JobOffersCard(jobItem: job)).toList(),
//       ),
//     );
//   }
// }

// class TabItem extends StatelessWidget {
//   final String title;
//   final String count;

//   const TabItem({required this.title, required this.count});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 124,
//       height: 70,
//       alignment: Alignment.center,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(count,
//               style:
//                   const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
//           const SizedBox(height: 5),
//           Text(title,
//               style:
//                   const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
//         ],
//       ),
//     );
//   }
}
