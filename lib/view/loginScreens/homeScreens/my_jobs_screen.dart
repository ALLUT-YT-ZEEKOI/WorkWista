import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

// Import your controllers and models
import 'package:workwista/view/Controllers/jobs_screen_controller.dart';
import 'package:workwista/view/Model/posted_jobs_model.dart';

class MyJobsScreen extends StatefulWidget {
  const MyJobsScreen({super.key});

  @override
  _MyJobsScreenState createState() => _MyJobsScreenState();
}

class _MyJobsScreenState extends State<MyJobsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentTabIndex = 0;
  final List<String> _tabs = [
    'Pending',
    'Rejected',
    'Completed',
    'Posted Jobs'
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_onTabChanged);

    // Load data when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final jobsController = context.read<JobsScreenController>();
      jobsController.getMyJobs();
      jobsController.getPostedJobs(); // Load posted jobs initially
    });
  }

  void _onTabChanged() {
    if (_tabController.indexIsChanging) {
      setState(() {
        _currentTabIndex = _tabController.index;
      });
      _loadDataForCurrentTab();
    }
  }

  void _loadDataForCurrentTab() {
    final jobsController = context.read<JobsScreenController>();

    switch (_currentTabIndex) {
      case 0: // Pending
        jobsController.getMyJobs();
        break;
      case 1: // Rejected
        jobsController.getPostedJobs();
        // Implement if needed
        break;
      case 2: // Completed
        jobsController.getPostedJobs();
        // Implement if needed
        break;
      case 3: // Posted Jobs
        jobsController.getPostedJobs();
        break;
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
                 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'My Jobs',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: false,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))],
      ),
      body: Column(
        children: [
          // Custom Tab Bar
          Container(
            margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12),
            height: 48.h,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  _tabs.length,
                  (index) {
                    final isSelected = _currentTabIndex == index;
                    return Padding(
                      padding: EdgeInsets.only(
                          left: 0.w, right: 12.w, top: 8.h, bottom: 8.h),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _currentTabIndex = index;
                          });
                          _loadDataForCurrentTab();
                        },
                        child: Container(
                          constraints:
                              BoxConstraints(minWidth: 70.w, minHeight: 32.h),
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.w,
                              color: isSelected
                                  ? Color(0xff06407E)
                                  : Color(0xffE2E8F0),
                            ),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24.w),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            _tabs[index],
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: isSelected
                                  ? Color(0xff002D64)
                                  : Color(0xff92A5B5),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Divider(),
          // Tab Content
          Expanded(
            child: IndexedStack(
              index: _currentTabIndex,
              children: [
                // Pending Tab
                Consumer<JobsScreenController>(
                  builder: (context, jobsController, child) {
                    return _buildPendingTab(jobsController);
                  },
                ),

                // Rejected Tab
                Consumer<JobsScreenController>(
                  builder: (context, jobsController, child) {
                    return _buildRejectedTab(jobsController);
                  },
                ),

                // Completed Tab
                Consumer<JobsScreenController>(
                  builder: (context, jobsController, child) {
                    return _buildCompletedTab(jobsController);
                  },
                ),

                // Posted Jobs Tab
                Consumer<JobsScreenController>(
                  builder: (context, jobsController, child) {
                    return _buildPostedJobsTab(jobsController);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPendingTab(JobsScreenController controller) {
    if (controller.isloading) {
      return _buildLoadingWidget();
    }

    if (controller.postedJobsList.isEmpty) {
      return _buildEmptyState(
        icon: Icons.work_outline,
        title: 'No Posted Jobs',
        subtitle: 'You haven\'t posted any jobs yet.',
      );
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      itemCount: controller.postedJobsList.length,
      itemBuilder: (context, index) {
        final postedJob = controller.postedJobsList[index];
        return _buildJobCard(
          postedJob: postedJob,
          statusColor: Colors.orange,
          // statusText: 'Pending',
          onTap: () {
            // Navigate to job details
          },
        );
      },
    );
  }

  Widget _buildRejectedTab(JobsScreenController controller) {
    if (controller.isloading) {
      return _buildLoadingWidget();
    }

    if (controller.postedJobsList.isEmpty) {
      return _buildEmptyState(
        icon: Icons.work_outline,
        title: 'No Posted Jobs',
        subtitle: 'You haven\'t posted any jobs yet.',
      );
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      itemCount: controller.postedJobsList.length,
      itemBuilder: (context, index) {
        final postedJob = controller.postedJobsList[index];
        return _buildJobCard(
          postedJob: postedJob,
          statusColor: Colors.green,
          // statusText: job.isPaid ?? false ? 'Paid' : 'Completed',
          onTap: () {
            // Navigate to job details
          },
        );
      },
    );
  }

  Widget _buildCompletedTab(JobsScreenController controller) {
    if (controller.isloading) {
      return _buildLoadingWidget();
    }

    if (controller.postedJobsList.isEmpty) {
      return _buildEmptyState(
        icon: Icons.work_outline,
        title: 'No Posted Jobs',
        subtitle: 'You haven\'t posted any jobs yet.',
      );
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      itemCount: controller.postedJobsList.length,
      itemBuilder: (context, index) {
        final postedJob = controller.postedJobsList[index];
        return _buildJobCard(
          postedJob: postedJob,
          statusColor: Colors.green,
          // statusText: job.isPaid ?? false ? 'Paid' : 'Completed',
          onTap: () {
            // Navigate to job details
          },
        );
      },
    );
  }

  Widget _buildPostedJobsTab(JobsScreenController controller) {
    if (controller.postedJobsList.isEmpty) {
      return _buildEmptyState(
        icon: Icons.work_outline,
        title: 'No Posted Jobs',
        subtitle: 'You haven\'t posted any jobs yet.',
      );
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      itemCount: controller.postedJobsList.length,
      itemBuilder: (context, index) {
        final postedJob = controller.postedJobsList[index];
        return _buildJobCard(
          postedJob: postedJob,
          statusColor: Colors.green,
          onTap: () {
            // Handle tap on posted job
          },
        );
      },
    );
  }

  Widget _buildJobCard({
    required PostedItem postedJob,
    required Color statusColor,
    // required String statusText,
    required VoidCallback onTap,
  }) {
    return Container(
      height: 137.h,
      width: 373.w,
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color(0xffDAE1E7), width: 1.5.w),
        borderRadius: BorderRadius.circular(15.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(
                left: 4.w,
                right: 4.w,
                top: 5.h,
              ),
              child: Container(
                width: 373.w,
                height: 122.h,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xff2B6699),
                    width: 1.w,
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.w),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 9.w, vertical: 11.h),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 24.w,
                            foregroundImage: NetworkImage(
                                'https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
                            backgroundColor: Colors.red,
                          ),
                          SizedBox(width: 4.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        postedJob.title ?? "No title",
                                        style: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15.w,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: '₹',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16.sp,
                                              height: 1.0,
                                              letterSpacing: 0.0,
                                              color: Colors.black,
                                            ),
                                          ),
                                          TextSpan(
                                            text: postedJob.salary_from != null
                                                ? double.tryParse(postedJob
                                                            .salary_from!)
                                                        ?.toInt()
                                                        .toString() ??
                                                    "0"
                                                : "Salary not specified",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16.sp,
                                              height: 1.0,
                                              letterSpacing: 0.0,
                                              color: Colors.black,
                                            ),
                                          ),
                                          TextSpan(
                                            text: ' - ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16.sp,
                                              height: 1.0,
                                              letterSpacing: 0.0,
                                              color: Colors.black,
                                            ),
                                          ),
                                          TextSpan(
                                            text: postedJob.salary_to != null
                                                ? double.tryParse(postedJob
                                                            .salary_to!)
                                                        ?.toInt()
                                                        .toString() ??
                                                    "0"
                                                : "Salary not specified",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16.sp,
                                              height: 1.0,
                                              letterSpacing: 0.0,
                                              color: Colors.black,
                                            ),
                                          ),
                                          TextSpan(
                                            text: '/',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16.sp,
                                              height: 1.0,
                                              letterSpacing: 0.0,
                                              color: Colors.black,
                                            ),
                                          ),
                                          TextSpan(
                                            text: 'Day',
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
                                  ],
                                ),
                                SizedBox(height: 0.h),
                                Row(
                                  children: [
                                    Text(
                                      "Lulu Hyoermarket",
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Spacer(),
                                    Container(
                                      height: 22.h,
                                      width: 110.w,
                                      decoration: BoxDecoration(
                                        color: Color(0xffFFCED3),
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Only for 2 days",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xff8C1823),
                                              fontSize: 12.sp),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 13.w, vertical: 8.h),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5.w, vertical: 3.h),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(9.w),
                                        border: Border.all(
                                            color: Color(0xffCED7DE)),
                                      ),
                                      child: Row(
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: '₹',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12.sp,
                                                    height: 1.0,
                                                    letterSpacing: 0.0,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: postedJob.salary_from !=
                                                          null
                                                      ? double.tryParse(postedJob
                                                                  .salary_from!)
                                                              ?.toInt()
                                                              .toString() ??
                                                          "0"
                                                      : "Salary not specified",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12.sp,
                                                    height: 1.0,
                                                    letterSpacing: 0.0,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: ' - ',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12.sp,
                                                    height: 1.0,
                                                    letterSpacing: 0.0,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: postedJob.salary_to !=
                                                          null
                                                      ? double.tryParse(postedJob
                                                                  .salary_to!)
                                                              ?.toInt()
                                                              .toString() ??
                                                          "0"
                                                      : "Salary not specified",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12.sp,
                                                    height: 1.0,
                                                    letterSpacing: 0.0,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: ' Per ',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12.sp,
                                                    height: 1.0,
                                                    letterSpacing: 0.0,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: 'Day',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12.sp,
                                                    height: 1.5,
                                                    letterSpacing: 0.0,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )),
                                  Text(" • ",
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          color: Color(0xff0A0A0B))),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5.w, vertical: 3.h),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(9.w),
                                      border:
                                          Border.all(color: Color(0xffCED7DE)),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.access_time,
                                          size: 16.w,
                                          color: Color(0xff0A0A0B),
                                        ),
                                        SizedBox(width: 4.w),
                                        Text(
                                          "Full-Time",
                                          style: TextStyle(
                                              color: Color(0xff0A0A0B),
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(" • ",
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          color: Color(0xff0A0A0B))),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5.w, vertical: 3.h),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(9.w),
                                      border:
                                          Border.all(color: Color(0xffCED7DE)),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          size: 16.w,
                                          color: Color(0xff0A0A0B),
                                        ),
                                        SizedBox(width: 4.w),
                                        Text(
                                          "Onsite",
                                          style: TextStyle(
                                              color: Color(0xff0A0A0B),
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5.w, vertical: 3.h),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(9.w),
                                      border:
                                          Border.all(color: Color(0xffCED7DE)),
                                    ),
                                    child: Text(
                                      "+5",
                                      style: TextStyle(
                                          color: Color(0xff0A0A0B),
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildPostedJobsCard({
  //   required PostedItem postedJob,
  //   required VoidCallback onTap,
  // }) {
  //   return ContColor.fromARGB(255, 99, 159, 205)margin: EdgeInsets.only(bottom: 12.h),
  //     child: Card(
  //       elevation: 2,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(12.r),
  //       ),
  //       child: InkWell(
  //         onTap: onTap,
  //         borderRadius: BorderRadius.circular(12.r),
  //         child: Padding(
  //           padding: EdgeInsets.all(16.w),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Expanded(
  //                     child: Text(
  //                       postedJob.title ?? 'Job Title',
  //                       style: TextStyle(
  //                         fontSize: 16.sp,
  //                         fontWeight: FontWeight.w600,
  //                         color: Colors.black,
  //                       ),
  //                       maxLines: 1,
  //                       overflow: TextOverflow.ellipsis,
  //                     ),
  //                   ),
  //                   Container(
  //                     padding: EdgeInsets.symmetric(
  //                       horizontal: 8.w,
  //                       vertical: 4.h,
  //                     ),
  //                     decoration: BoxDecoration(
  //                       // ignore: deprecated_member_use
  //                       color: Colors.blue.withOpacity(0.1),
  //                       borderRadius: BorderRadius.circular(12.r),
  //                     ),
  //                     child: Text(
  //                       '${postedJob.requestsCount ?? 0} Requests',
  //                       style: TextStyle(
  //                         fontSize: 10.sp,
  //                         fontWeight: FontWeight.w500,
  //                         color: Colors.blue,
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               SizedBox(height: 8.h),
  //               Text(
  //                 postedJob.title ?? 'No description available',
  //                 style: TextStyle(
  //                   fontSize: 12.sp,
  //                   color: Colors.grey[600],
  //                 ),
  //                 maxLines: 2,
  //                 overflow: TextOverflow.ellipsis,
  //               ),
  //               SizedBox(height: 12.h),
  //               Row(
  //                 children: [
  //                   if (postedJob.salary_from != null &&
  //                       postedJob.salary_to != null) ...[
  //                     Icon(Icons.currency_rupee,
  //                         size: 14.sp, color: Colors.green),
  //                     Text(
  //                       '${postedJob.salary_from} - ${postedJob.salary_to}',
  //                       style: TextStyle(
  //                         fontSize: 14.sp,
  //                         fontWeight: FontWeight.w600,
  //                         color: Colors.green,
  //                       ),
  //                     ),
  //                     Spacer(),
  //                   ],
  //                   if (postedJob.jobDate != null) ...[
  //                     Icon(Icons.calendar_today,
  //                         size: 12.sp, color: Colors.grey),
  //                     SizedBox(width: 4.w),
  //                     Text(
  //                       DateFormat('yyyy-MM-dd').format(postedJob.jobDate!),
  //                       style: TextStyle(
  //                         fontSize: 11.sp,
  //                         color: Colors.grey[600],
  //                       ),
  //                     ),
  //                   ],
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildLoadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16.h),
          Text(
            'Loading...',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 64.w,
            color: Colors.grey[400],
          ),
          SizedBox(height: 16.h),
          Text(
            title,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
