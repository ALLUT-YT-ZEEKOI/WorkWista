import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:workwista/Utils/color_constants.dart';
import 'package:workwista/view/Controllers/apply_job_controller.dart';
import 'package:workwista/view/Controllers/job_details_screen_controller.dart';
import 'package:workwista/view/Wdigets/button_without_gradient.dart';
import 'package:workwista/view/Wdigets/gradient_button.dart';
import 'package:workwista/view/responsive_helper.dart';

// ignore: must_be_immutable
class JobDetailsScreen extends StatefulWidget {
  String? jobId;
  JobDetailsScreen({required this.jobId, super.key});

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await context
            .read<JobDetailsScreenController>()
            .getJobDetails(widget.jobId ?? "");
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<JobDetailsScreenController>();
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHight = MediaQuery.of(context).size.width;
    final PageController _controller = PageController();
    final int _numPages = 3;

    // Show loading indicator
    if (controller.isloading) {
      return Center(child: CircularProgressIndicator());
    }

    // Show error if no data
    if (controller.jobDetails == null) {
      return Center(child: Text("Failed to load job details"));
    }
    final job = controller.jobDetails!.data;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Job Details",
          style: TextStyle(
              color: Colors.black,
              fontSize: 20.sp,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding:
            EdgeInsetsDirectional.symmetric(horizontal: 10.w, vertical: 18.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 203.h,
                child: PageView(
                  controller: _controller,
                  children: [
                    Container(
                      width: 373.w,
                      height: 203.h,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  'https://images.pexels.com/photos/125532/pexels-photo-125532.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2')),
                          borderRadius: BorderRadius.circular(11.r),
                          color: Colors.amber),
                    ),
                    Container(
                      width: 373.w,
                      height: 203.h,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  'https://images.pexels.com/photos/125532/pexels-photo-125532.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2')),
                          borderRadius: BorderRadius.circular(11.r),
                          color: Colors.amber),
                    ),
                    Container(
                      width: 373.w,
                      height: 203.h,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  'https://images.pexels.com/photos/125532/pexels-photo-125532.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2')),
                          borderRadius: BorderRadius.circular(11.r),
                          color: Colors.amber),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              Center(
                child: SmoothPageIndicator(
                  controller: _controller,
                  count: _numPages,
                  effect: WormEffect(
                    dotHeight: 3.h,
                    dotWidth: 19.w,
                    activeDotColor: ColorConstants.indicatorBlue,
                    dotColor: Color(0xffD9D9D9),
                  ),
                ),
              ),
              SizedBox(
                height: 37.h,
              ),
              Row(
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '₹',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 20.sp,
                            height: 1.0,
                            letterSpacing: 0.0,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: job?.salary ?? "Salary not specified",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 24.sp,
                            height: 1.0,
                            letterSpacing: 0.0,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: '/',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20.sp,
                            height: 1.0,
                            letterSpacing: 0.0,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: 'month',
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
                  Spacer(),
                  Icon(
                    Icons.bookmark_border_outlined,
                    size: 24,
                  )
                ],
              ),
              Text(
                "1 vacancy for Sales Staff",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: ResponsiveHelper.height(24, context),
              ),
              Padding(
                padding: EdgeInsets.only(left: 22.w),
                child: Column(children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/location2.png',
                        width: 18.w,
                        height: 18.h,
                      ),
                      SizedBox(
                        width: 6.w,
                      ),
                      Text(
                        "Ernakulam",
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: ColorConstants.lighttext),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 7.h,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        'assets/building.png',
                        width: 18.w,
                        height: 18.h,
                      ),
                      SizedBox(
                        width: 6.w,
                      ),
                      Text(
                        "Lulu HyperMarket",
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: ColorConstants.indicatorBlue),
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Icon(
                        Icons.north_east,
                        size: 18,
                        color: ColorConstants.indicatorBlue,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 7.h,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        'assets/flag_black.png',
                        width: 18.w,
                        height: 18.h,
                      ),
                      SizedBox(
                        width: 6.w,
                      ),
                      Text(
                        "Full time",
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ]),
              ),
              SizedBox(
                height: 25.h,
              ),
              Text(
                "Job description",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 8.h,
              ),
              Text(
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                "Join our dynamic sales team as a Sales Executive! In this role, you'll be responsible for driving revenue growth by building strong relationships with clients and identifying their needs. You'll engage with potential customers, present our innovative solutions, and close deals to meet and exceed sales targets. We value creativity and initiative, so you'll have the freedom to develop your own strategies for success. If you're passionate about sales and eager to make an impact, we want to hear from you!",
                style: TextStyle(
                    color: ColorConstants.descText,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Key Responsbilities",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 8.h,
              ),
              Text(
                "Develop and implement effective sales strategies to drive revenue growth. - Identify and engage potential clients through networking and outreach efforts more. - Conduct market research to understand customer needs and preferences. - Prepare and deliver compelling sales presentations to prospective clients. - Collaborate with the marketing team to create promotional materials and campaigns. - Maintain accurate records of sales activities and customer interactions in the CRM system. - Provide exceptional customer service to build long-term relationships with clients. - Meet or exceed monthly and quarterly sales targets.",
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: ColorConstants.descText,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 24.h,
              ),
              Text(
                "Skills",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 12.h,
              ),
              Row(
                children: [
                  skillsContainer(context, "Cumunication skills"),
                  SizedBox(
                    width: 12.w,
                  ),
                  skillsContainer(context, "Product knowledge"),
                ],
              ),
              SizedBox(
                height: 12.h,
              ),
              Row(
                children: [
                  skillsContainer(context, "Active listening"),
                  SizedBox(
                    width: 12.w,
                  ),
                  skillsContainer(context, "Time Management"),
                ],
              ),
              SizedBox(
                height: 16.h,
              ),
              GradientButton(
                onPressed: () async {
                  await context.read<ApplyJobController>().onApplyJob(
                        context: context,
                        Jobid: job?.id ?? "id not found",
                      );
                },
                name: "Apply job",
                width: 373.w,
                height: 44.h,
              ),
              SizedBox(
                height: 4.h,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: ButtonWithoutGradient(
                  name: "Back",
                ),
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
