import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:workwista/Utils/color_constants.dart';
import 'package:workwista/view/Wdigets/companiescard.dart';
import 'package:workwista/view/Wdigets/greencard.dart';
import 'package:workwista/view/Wdigets/jobofferscard.dart';
import 'package:workwista/view/Wdigets/search_field.dart';
import 'package:workwista/view/responsive_helper.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _pageController = PageController(initialPage: _currentIndex);

    // Add listener to sync tab controller with page changes
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      _pageController.jumpToPage(_tabController.index);
      setState(() {
        _currentIndex = _tabController.index;
      });
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: ResponsiveHelper.width(10, context)),
            child: Column(
              children: [
                // App bar content
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
                              width: ResponsiveHelper.width(119, context),
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
                                      fontSize: 13,
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

                // Discover Jobs heading
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

                // Tab Bar
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: ResponsiveHelper.width(10, context)),
                  height: ResponsiveHelper.height(35, context),
                  child: TabBar(
                    tabAlignment: TabAlignment.start,
                    controller: _tabController,
                    isScrollable: true,
                    labelColor: Colors.blue,
                    unselectedLabelColor: Colors.grey,
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.04,
                    ),
                    unselectedLabelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.04,
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.blue,
                        width: 2,
                      ),
                    ),
                    dividerColor: Colors.transparent,
                    splashFactory: NoSplash.splashFactory,
                    overlayColor: WidgetStateProperty.all(Colors.transparent),
                    onTap: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    tabs: [
                      Tab(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: ResponsiveHelper.width(12, context),
                            vertical: ResponsiveHelper.height(7, context),
                          ),
                          child: Text("All"),
                        ),
                      ),
                      Tab(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: ResponsiveHelper.width(12, context),
                            vertical: ResponsiveHelper.height(7, context),
                          ),
                          child: Text("IT"),
                        ),
                      ),
                      Tab(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: ResponsiveHelper.width(12, context),
                            vertical: ResponsiveHelper.height(7, context),
                          ),
                          child: Text("Local Jobs"),
                        ),
                      ),
                      Tab(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: ResponsiveHelper.width(12, context),
                            vertical: ResponsiveHelper.height(7, context),
                          ),
                          child: Text("Remote Jobs"),
                        ),
                      ),
                      Tab(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: ResponsiveHelper.width(12, context),
                            vertical: ResponsiveHelper.height(7, context),
                          ),
                          child: Text("New Jobs"),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 28),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ResponsiveHelper.width(10, context),
                    // vertical: ResponsiveHelper.height(18, context),
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
                SizedBox(
                  height: ResponsiveHelper.height(12, context),
                ),
                // Tab content based on selected tab
                Builder(
                  builder: (context) {
                    switch (_currentIndex) {
                      case 0:
                        return JobCategoryScreen1();
                      case 1:
                        return JobCategoryScreen2();
                      case 2:
                        return JobCategoryScreen3();
                      case 3:
                        return JobCategoryScreen4();
                      case 4:
                        return JobCategoryScreen5();
                      default:
                        return JobCategoryScreen1();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class JobCategoryScreen1 extends StatelessWidget {
  const JobCategoryScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController _controller = PageController();
    final int _numPages = 3;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHight = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        JobOffersCard(),
        SizedBox(
          height: ResponsiveHelper.height(30, context),
        ),
        Row(
          children: [
            Text(
              "Companies nearby",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
            Spacer(),
            Text(
              "View More",
              style: TextStyle(
                  color: ColorConstants.viewMoreText,
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
        SizedBox(
          height: ResponsiveHelper.height(18, context),
        ),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 150,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  separatorBuilder: (context, index) => Container(
                    width: ResponsiveHelper.width(
                        5, context), // Height of the separator
                    color: Colors.transparent, // Color of the separator
                  ),
                  itemBuilder: (context, index) {
                    return CompaniesCard();
                  },
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: ResponsiveHelper.height(22, context),
        ),
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
          height: ResponsiveHelper.height(10, context),
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
    );
  }
}

class JobCategoryScreen2 extends StatelessWidget {
  const JobCategoryScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController _controller = PageController();
    final int _numPages = 3;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHight = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        JobOffersCard(),
        SizedBox(
          height: 30,
        ),
        Row(
          children: [
            Text(
              "Companies nearby",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
            Spacer(),
            Text(
              "View More",
              style: TextStyle(
                  color: ColorConstants.viewMoreText,
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
        SizedBox(
          height: 18,
        ),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 150,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  separatorBuilder: (context, index) => Container(
                    width: 5, // Height of the separator
                    color: Colors.transparent, // Color of the separator
                  ),
                  itemBuilder: (context, index) {
                    return CompaniesCard();
                  },
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 22,
        ),
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
    );
  }
}

class JobCategoryScreen3 extends StatelessWidget {
  const JobCategoryScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController _controller = PageController();
    final int _numPages = 3;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHight = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        JobOffersCard(),
        SizedBox(
          height: 30,
        ),
        Row(
          children: [
            Text(
              "Companies nearby",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
            Spacer(),
            Text(
              "View More",
              style: TextStyle(
                  color: ColorConstants.viewMoreText,
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
        SizedBox(
          height: 18,
        ),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 150,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  separatorBuilder: (context, index) => Container(
                    width: 5, // Height of the separator
                    color: Colors.transparent, // Color of the separator
                  ),
                  itemBuilder: (context, index) {
                    return CompaniesCard();
                  },
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 22,
        ),
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
    );
  }
}

class JobCategoryScreen4 extends StatelessWidget {
  const JobCategoryScreen4({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController _controller = PageController();
    final int _numPages = 3;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHight = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        JobOffersCard(),
        SizedBox(
          height: 30,
        ),
        Row(
          children: [
            Text(
              "Companies nearby",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
            Spacer(),
            Text(
              "View More",
              style: TextStyle(
                  color: ColorConstants.viewMoreText,
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
        SizedBox(
          height: 18,
        ),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 150,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  separatorBuilder: (context, index) => Container(
                    width: 5, // Height of the separator
                    color: Colors.transparent, // Color of the separator
                  ),
                  itemBuilder: (context, index) {
                    return CompaniesCard();
                  },
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 22,
        ),
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
    );
  }
}

class JobCategoryScreen5 extends StatelessWidget {
  const JobCategoryScreen5({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController _controller = PageController();
    final int _numPages = 3;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHight = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        JobOffersCard(),
        SizedBox(
          height: 30,
        ),
        Row(
          children: [
            Text(
              "Companies nearby",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
            Spacer(),
            Text(
              "View More",
              style: TextStyle(
                  color: ColorConstants.viewMoreText,
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
        SizedBox(
          height: 18,
        ),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 150,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  separatorBuilder: (context, index) => Container(
                    width: 5, // Height of the separator
                    color: Colors.transparent, // Color of the separator
                  ),
                  itemBuilder: (context, index) {
                    return CompaniesCard();
                  },
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 22,
        ),
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
    );
  }
}
