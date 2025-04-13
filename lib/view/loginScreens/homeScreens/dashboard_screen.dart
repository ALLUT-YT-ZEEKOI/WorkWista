import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:workwista/Utils/color_constants.dart';
import 'package:workwista/view/Controllers/jobs_screen_controller.dart';
import 'package:workwista/view/Wdigets/companiescard.dart';

import 'package:workwista/view/Wdigets/greencard.dart';
import 'package:workwista/view/Wdigets/jobofferscard.dart';
import 'package:workwista/view/Wdigets/search_field.dart';
import 'package:workwista/view/loginScreens/homeScreens/categories_screen.dart';
import 'package:workwista/view/loginScreens/homeScreens/job_details_screen.dart';

import 'package:workwista/view/responsive_helper.dart';

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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timestamp) async {
      // Select 'All' categroy by default

      final jobsController = context.read<JobsScreenController>();
      await jobsController.getCategories(); // Fetch categories first
      await jobsController.getJobs(); // Then fetch all jobs
    });

    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      context
          .read<JobsScreenController>()
          .getCategories(); // Select 'All' categroy by default
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHight = MediaQuery.of(context).size.width;
    final PageController _controller = PageController();
    final int _numPages = 3;
    // final controller = Provider.of<JobsScreenController>(context);
    return SafeArea(
      child: Consumer<JobsScreenController>(
        builder: (context, jobsScreenControllerObj, child) {
          return SingleChildScrollView(
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
                          horizontal: ResponsiveHelper.width(10, context),
                          vertical: ResponsiveHelper.height(7, context),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image(
                              image: AssetImage('assets/Frame 26080486.png'),
                              width: ResponsiveHelper.width(40, context),
                            ),
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      right:
                                          ResponsiveHelper.width(10, context)),
                                  child: Image(
                                    image: AssetImage('assets/bell.png'),
                                    width: ResponsiveHelper.width(30, context),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      right:
                                          ResponsiveHelper.width(10, context)),
                                  child: Image(
                                    image: AssetImage(
                                        'assets/ant-design_message-outlined.png'),
                                    width: ResponsiveHelper.width(30, context),
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
                          horizontal: ResponsiveHelper.width(10, context),
                          vertical: ResponsiveHelper.height(18, context),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: searchField(
                                height: 50,
                              ),
                            ),
                            SizedBox(width: ResponsiveHelper.width(5, context)),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: ColorConstants.containerBorder,
                                  width: 3,
                                ),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              height: ResponsiveHelper.height(50, context),
                              width: ResponsiveHelper.width(125, context),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset(
                                    'assets/location.png',
                                    height:
                                        ResponsiveHelper.height(24, context),
                                    width: ResponsiveHelper.width(24, context),
                                  ),
                                  Text(
                                    "Eranakulam",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
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
                    horizontal: ResponsiveHelper.width(10, context),
                    vertical: ResponsiveHelper.height(18, context),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Discover Jobs",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
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
                            fontSize: 12,
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
                          padding: const EdgeInsets.all(8),
                          child: InkWell(
                            onTap: () {
                              jobsScreenControllerObj.onCategorySelected(index);
                              // No need for additional calls here since onCategorySelected now handles it
                            },
                            child: Container(
                              constraints: BoxConstraints(
                                  minWidth: 70,
                                  minHeight: 32), // 👈 Ensures a minimum size
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: isSelected
                                      ? Colors.blue
                                      : Colors.grey.shade400,
                                ),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(24),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                categoryTitle,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: isSelected
                                      ? Colors.blue
                                      : Colors.grey.shade500,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 28),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ResponsiveHelper.width(10, context),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Near Jobs",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        "View More",
                        style: TextStyle(
                          color: ColorConstants.viewMoreText,
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: ResponsiveHelper.height(12, context)),

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
                                  size: 64,
                                  color: Colors.grey[400],
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  "No jobs available",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                if (jobsScreenControllerObj
                                        .selectedCategoryIndex !=
                                    0)
                                  Text(
                                    "for this category",
                                    style: TextStyle(
                                      fontSize: 14,
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
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ResponsiveHelper.width(10, context),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Companies nearby",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "View More",
                            style: TextStyle(
                              color: ColorConstants.viewMoreText,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: ResponsiveHelper.height(18, context)),
                      SizedBox(
                        height: 150,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          padding: EdgeInsets.symmetric(
                            horizontal: ResponsiveHelper.width(10, context),
                          ),
                          separatorBuilder: (context, index) => SizedBox(
                            width: ResponsiveHelper.width(10, context),
                          ),
                          itemBuilder: (context, index) {
                            return Material(
                              child: CompaniesCard(),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: ResponsiveHelper.height(22, context)),
                      SizedBox(
                        height: 200,
                        child: PageView(
                          controller: _controller,
                          children: [
                            GreenCard(),
                            GreenCard(),
                            GreenCard(),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: SmoothPageIndicator(
                          controller: _controller,
                          count: _numPages,
                          effect: WormEffect(
                            dotHeight: screenHight * 0.020,
                            dotWidth: screenWidth * 0.016,
                            activeDotColor: Colors.black,
                            dotColor: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
