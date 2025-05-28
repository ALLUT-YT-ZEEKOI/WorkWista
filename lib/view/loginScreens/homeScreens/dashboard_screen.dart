import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:workwista/Utils/color_constants.dart';
import 'package:workwista/view/Controllers/jobs_screen_controller.dart';
import 'package:workwista/view/Controllers/location_provider_controller.dart';
import 'package:workwista/view/Wdigets/companiescard.dart';

import 'package:workwista/view/Wdigets/greencard.dart';
import 'package:workwista/view/Wdigets/jobofferscard.dart';
import 'package:workwista/view/Wdigets/search_field.dart';
import 'package:workwista/view/loginScreens/homeScreens/categories_screen.dart';
import 'package:workwista/view/loginScreens/homeScreens/job_details_screen.dart';
import 'package:workwista/view/loginScreens/homeScreens/search_screen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  // late TabController _tabController;
  // late PageController _pageController;
  // int _currentIndex = 0;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);

    // Apply correct initial status bar color immediately
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _updateStatusBarBasedOnOffset();

      final jobsController = context.read<JobsScreenController>();
      await jobsController.getCategories();
      await jobsController.getJobs();

      // Initialize location once when app starts
      final locationProvider = context.read<LocationProvider>();
      if (locationProvider.cityName == 'not found') {
        await locationProvider.getCurrentLocationAndCity();
      }
    });
  }

  void _updateStatusBarBasedOnOffset() {
    if (_scrollController.hasClients && _scrollController.offset > 100) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
      );
    } else {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: Color(0xFFDAE6FC),
          statusBarIconBrightness: Brightness.dark,
        ),
      );
    }
  }

  void _onScroll() {
    _updateStatusBarBasedOnOffset();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHight = MediaQuery.of(context).size.width;
    final PageController _controller = PageController();
    final int _numPages = 3;
    // final controller = Provider.of<JobsScreenController>(context);
    return SafeArea(
      child: Consumer<JobsScreenController>(
        builder: (context, jobsScreenControllerObj, child) {
          return Container(
            color: Colors.white,
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  // App bar content (unchanged)
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.50, -0.00),
                        end: Alignment(0.50, 1.89),
                        colors: [Color(0xFFDAE6FC), Colors.white],
                      ),
                    ),
                    child: Column(
                      children: [
                        // Header with logo and notifications
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 7.h,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                radius: 22.w,
                                child: Image(
                                  image:
                                      AssetImage('assets/Frame 26080486.png'),
                                ),
                              ),
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 23.w,
                                    backgroundColor: Colors.white,
                                    child: Image(
                                      image: AssetImage('assets/bell.png'),
                                      width: 30.w,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 12.w,
                                  ),
                                  CircleAvatar(
                                    radius: 23.w,
                                    backgroundColor: Colors.white,
                                    child: Image(
                                      image: AssetImage(
                                          'assets/ant-design_message-outlined.png'),
                                      width: 30.w,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // Search and location
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 18.h,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SearchScreen()),
                                    );
                                  },
                                  child: IgnorePointer(
                                    child: SearchField(height: 50.h),
                                  ),
                                ),
                              ),
                              SizedBox(width: 5.w),
                              InkWell(
                                onTap: () {
                                  // Retry location when tapped
                                  // Optionally allow manual refresh
                                  locationProvider.getCurrentLocationAndCity();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: ColorConstants.containerBorder
                                          // ignore: deprecated_member_use
                                          .withOpacity(0.9),
                                      width: 2.w,
                                    ),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12.w),
                                  ),
                                  height: 47.5.h,
                                  width: 125.w,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      locationProvider.isLoadingLocation
                                          ? SizedBox(
                                              width: 16.w,
                                              height: 16.h,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: Colors.grey[600],
                                              ),
                                            )
                                          : Image.asset(
                                              'assets/location.png',
                                              height: 24.h,
                                              width: 24.w,
                                            ),
                                      Flexible(
                                        child: Text(
                                          overflow: TextOverflow.ellipsis,
                                          locationProvider.cityName,
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 18.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Discover Jobs",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 18.sp,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CategoriesScreen(),
                                ));
                          },
                          child: Text(
                            "View More",
                            style: TextStyle(
                              color: ColorConstants.viewMoreText,
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Categories horizontal scroll (unchanged)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        jobsScreenControllerObj.categoriesList.length + 1,
                        (index) {
                          final isAll = index == 0;
                          final isSelected =
                              jobsScreenControllerObj.selectedCategoryIndex ==
                                  index;
                          final categoryTitle = isAll
                              ? "All"
                              : jobsScreenControllerObj
                                      .categoriesList[index - 1].title ??
                                  "Unnamed";
                          return Padding(
                            padding: EdgeInsets.only(
                                left: 8.w, right: 8.w, top: 8.h, bottom: 8.h),
                            child: InkWell(
                              onTap: () {
                                jobsScreenControllerObj
                                    .onCategorySelected(index);
                                // No need for additional calls here since onCategorySelected now handles it
                              },
                              child: Container(
                                constraints: BoxConstraints(
                                    minWidth: 70.w, minHeight: 32.h),
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
                                  categoryTitle,
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
                  SizedBox(height: 28.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Near Jobs",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 18.sp,
                          ),
                        ),
                        Text(
                          "View More",
                          style: TextStyle(
                            color: ColorConstants.viewMoreText,
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),

                  // Job List
                  jobsScreenControllerObj.isloading
                      ? const Center(child: CircularProgressIndicator())
                      : jobsScreenControllerObj.jobsList.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.work_outline,
                                    size: 64.w,
                                    color: Colors.grey[400],
                                  ),
                                  SizedBox(height: 16.h),
                                  Text(
                                    "No jobs available",
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  if (jobsScreenControllerObj
                                          .selectedCategoryIndex !=
                                      0)
                                    Text(
                                      "for this category",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.grey[500],
                                      ),
                                    ),
                                ],
                              ),
                            )
                          : Column(
                              children: List.generate(
                                jobsScreenControllerObj.jobsList.length,
                                (index) {
                                  final jobItem =
                                      jobsScreenControllerObj.jobsList[index];
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                JobDetailsScreen(
                                                    jobId: jobItem.id),
                                          ));
                                    },
                                    child: JobOffersCard(jobItem: jobItem),
                                  );
                                },
                              ),
                            ),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(
                  //     horizontal: 10.w,
                  //   ),
                  //   child: Column(
                  //     children: [
                  //       Row(
                  //         children: [
                  //           Text(
                  //             "Companies nearby",
                  //             style: TextStyle(
                  //               color: Colors.black,
                  //               fontSize: 18.sp,
                  //               fontWeight: FontWeight.w700,
                  //             ),
                  //           ),
                  //           Spacer(),
                  //           Text(
                  //             "View More",
                  //             style: TextStyle(
                  //               color: ColorConstants.viewMoreText,
                  //               fontSize: 12.sp,
                  //               fontWeight: FontWeight.w400,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //       SizedBox(height: 18.h),
                  //       SizedBox(
                  //         height: 150.h,
                  //         child: ListView.separated(
                  //           scrollDirection: Axis.horizontal,
                  //           itemCount: 5,
                  //           padding: EdgeInsets.symmetric(
                  //             horizontal: 10.w,
                  //           ),
                  //           separatorBuilder: (context, index) => SizedBox(
                  //             width: 10.w,
                  //           ),
                  //           itemBuilder: (context, index) {
                  //             return Material(
                  //               child: CompaniesCard(),
                  //             );
                  //           },
                  //         ),
                  //       ),
                  //       SizedBox(height: 22.h),
                  //       SizedBox(
                  //         height: 200.h,
                  //         child: PageView(
                  //           controller: _controller,
                  //           children: [
                  //             GreenCard(),
                  //             GreenCard(),
                  //             GreenCard(),
                  //           ],
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         height: 10.h,
                  //       ),
                  //       Center(
                  //         child: SmoothPageIndicator(
                  //           controller: _controller,
                  //           count: _numPages,
                  //           effect: WormEffect(
                  //             dotHeight: screenHight * 0.020.h,
                  //             dotWidth: screenWidth * 0.016.w,
                  //             activeDotColor: Colors.black,
                  //             dotColor: Colors.black,
                  //           ),
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         height: 50.h,
                  //       )
                  //     ],
                  //   ),
                  // )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
