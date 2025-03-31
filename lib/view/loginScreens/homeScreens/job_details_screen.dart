import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:workwista/Utils/color_constants.dart';
import 'package:workwista/view/responsive_helper.dart';

class JobDetailsScreen extends StatefulWidget {
  const JobDetailsScreen({super.key});

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHight = MediaQuery.of(context).size.width;
    final PageController _controller = PageController();
    final int _numPages = 3;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Job Details",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 10, vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: ResponsiveHelper.height(200, context),
                child: PageView(
                  controller: _controller,
                  children: [
                    Container(
                      width: 375,
                      height: 205,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  'https://images.pexels.com/photos/125532/pexels-photo-125532.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2')),
                          borderRadius: BorderRadius.circular(11),
                          color: Colors.amber),
                    ),
                    Container(
                      width: 375,
                      height: 205,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  'https://images.pexels.com/photos/31164671/pexels-photo-31164671/free-photo-of-snowy-urban-scene-with-taxi-in-snowfall.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2')),
                          borderRadius: BorderRadius.circular(11),
                          color: Colors.amber),
                    ),
                    Container(
                      width: 375,
                      height: 205,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  'https://images.pexels.com/photos/30953519/pexels-photo-30953519/free-photo-of-couple-with-umbrella-at-kyoto-crosswalk.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2')),
                          borderRadius: BorderRadius.circular(11),
                          color: Colors.amber),
                    ),
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
                    dotHeight: screenHight * 0.010,
                    dotWidth: screenWidth * 0.035,
                    activeDotColor: ColorConstants.indicatorBlue,
                    dotColor: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: 37,
              ),
              Row(
                children: [],
              )
            ],
          ),
        ),
      ),
    );
  }
}
