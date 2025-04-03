

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:workwista/Utils/color_constants.dart';
import 'package:workwista/view/Wdigets/button_without_gradient.dart';
import 'package:workwista/view/Wdigets/gradient_button.dart';
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
        padding: EdgeInsetsDirectional.symmetric(
            horizontal: ResponsiveHelper.width(10, context),
            vertical: ResponsiveHelper.height(16, context)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: ResponsiveHelper.height(200, context),
                child: PageView(
                  controller: _controller,
                  children: [
                    Container(
                      width: ResponsiveHelper.width(375, context),
                      height: ResponsiveHelper.height(205, context),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  'https://images.pexels.com/photos/125532/pexels-photo-125532.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2')),
                          borderRadius: BorderRadius.circular(11),
                          color: Colors.amber),
                    ),
                    Container(
                      width: ResponsiveHelper.width(375, context),
                      height: ResponsiveHelper.height(205, context),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  'https://images.pexels.com/photos/125532/pexels-photo-125532.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2')),
                          borderRadius: BorderRadius.circular(11),
                          color: Colors.amber),
                    ),
                    Container(
                      width: ResponsiveHelper.width(375, context),
                      height: ResponsiveHelper.height(205, context),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  'https://images.pexels.com/photos/125532/pexels-photo-125532.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2')),
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
                height: ResponsiveHelper.height(37, context),
              ),
              Row(
                children: [
                  Text(
                    "₹15000/month",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w400),
                  ),
                  Spacer(),
                  Icon(Icons.bookmark_border_outlined)
                ],
              ),
              Text(
                "1 vacancy for Sales Staff",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: ResponsiveHelper.height(24, context),
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/location2.png',
                    width: ResponsiveHelper.width(12, context),
                    height: ResponsiveHelper.height(15, context),
                  ),
                  SizedBox(
                    width: ResponsiveHelper.width(6, context),
                  ),
                  Text(
                    "Ernakulam",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: ColorConstants.lighttext),
                  )
                ],
              ),
              SizedBox(
                height: 2,
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/building.png',
                    width: ResponsiveHelper.width(12, context),
                    height: ResponsiveHelper.height(15, context),
                  ),
                  SizedBox(
                    width: ResponsiveHelper.width(6, context),
                  ),
                  Text(
                    "Lulu HyperMarket",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: ColorConstants.indicatorBlue),
                  ),
                  SizedBox(
                    width: ResponsiveHelper.width(2, context),
                  ),
                  Icon(
                    Icons.north_east,
                    size: 18,
                    color: ColorConstants.indicatorBlue,
                  )
                ],
              ),
              SizedBox(
                height: 2,
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/flag_black.png',
                    width: ResponsiveHelper.width(12, context),
                    height: ResponsiveHelper.height(15, context),
                  ),
                  SizedBox(
                    width: ResponsiveHelper.width(6, context),
                  ),
                  Text(
                    "Full time",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                ],
              ),
              SizedBox(
                height: ResponsiveHelper.height(40, context),
              ),
              Text(
                "Job description",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: ResponsiveHelper.height(8, context),
              ),
              Text(
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                "Join our dynamic sales team as a Sales Executive! In this role, you'll be responsible for driving revenue growth by building strong relationships with clients and identifying their needs. You'll engage with potential customers, present our innovative solutions, and close deals to meet and exceed sales targets. We value creativity and initiative, so you'll have the freedom to develop your own strategies for success. If you're passionate about sales and eager to make an impact, we want to hear from you!",
                style: TextStyle(
                    color: ColorConstants.descText,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: ResponsiveHelper.height(24, context),
              ),
              Text(
                "Key Responsbilities",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: ResponsiveHelper.height(8, context),
              ),
              Text(
                "Develop and implement effective sales strategies to drive revenue growth. - Identify and engage potential clients through networking and outreach efforts more. - Conduct market research to understand customer needs and preferences. - Prepare and deliver compelling sales presentations to prospective clients. - Collaborate with the marketing team to create promotional materials and campaigns. - Maintain accurate records of sales activities and customer interactions in the CRM system. - Provide exceptional customer service to build long-term relationships with clients. - Meet or exceed monthly and quarterly sales targets.",
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: ColorConstants.descText,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: ResponsiveHelper.height(24, context),
              ),
              Text(
                "Skills",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: ResponsiveHelper.height(12, context),
              ),
              Row(
                children: [
                  skillsContainer(context, "Cumunication skills"),
                  SizedBox(
                    width: ResponsiveHelper.width(12, context),
                  ),
                  skillsContainer(context, "Product knowledge"),
                ],
              ),
              SizedBox(
                height: ResponsiveHelper.height(12, context),
              ),
              Row(
                children: [
                  skillsContainer(context, "Active listening"),
                  SizedBox(
                    width: ResponsiveHelper.width(12, context),
                  ),
                  skillsContainer(context, "Time Management"),
                ],
              ),
              SizedBox(
                height: ResponsiveHelper.height(17, context),
              ),
              GradientButton(
                onPressed: () {
                  
                },
                name: "Apply job",
                width: 373,
                height: 44,
              ),
              SizedBox(
                height: ResponsiveHelper.height(10, context),
              ),
              ButtonWithoutGradient(
                name: "Back",
              )
            ],
          ),
        ),
      ),
    );
  }

  Container skillsContainer(BuildContext context, String skillText) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.width(12, context),
      ),
      height: ResponsiveHelper.height(36, context),
      constraints: BoxConstraints(
        maxWidth:
            ResponsiveHelper.width(180, context), // Add max width constraint
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(27),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            // Or use Expanded if you want to force maximum available space
            child: Text(
              skillText,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
