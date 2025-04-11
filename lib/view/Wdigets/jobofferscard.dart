import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workwista/Utils/color_constants.dart';
import 'package:workwista/view/Controllers/job_offers_card_controller.dart';
import 'package:workwista/view/loginScreens/homeScreens/job_details_screen.dart';
import 'package:workwista/view/responsive_helper.dart';

class JobOffersCard extends StatefulWidget {
  int numOfcards;
  final BuildContext context;
  JobOffersCard({super.key, required this.context, required this.numOfcards});

  @override
  State<JobOffersCard> createState() => _JobOffersCardState();
}

class _JobOffersCardState extends State<JobOffersCard> {
  @override
  void initState() {
    super.initState();
    // Fetch categories when the tab bar initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<JobOffersCardController>(widget.context, listen: false)
          .getJobOffersCardDetails();
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<JobOffersCardController>(context);

// Show loading indicator while fetching categories
    if (controller.isloading) {
      return Center(child: CircularProgressIndicator());
    }

    // Show error message if no categories available
    if (controller.JobOffersCardDetailsList.isEmpty) {
      return Center(child: Text("No jobs available"));
    }
    final itemCount =
        min(widget.numOfcards, controller.JobOffersCardDetailsList.length);
    return Column(
      children: List.generate(itemCount, (index) {
        // Get the current job offer data
        final jobOffer = controller.JobOffersCardDetailsList[index];
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => JobDetailsScreen(jobId: jobOffer.id,),
                ));
          },
          child: Container(
            height: 232,
            width: ResponsiveHelper.width(373, context),
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
                color: ColorConstants.containerwhite,
                border:
                    Border.all(color: ColorConstants.containerBorder, width: 2),
                borderRadius: BorderRadius.circular(15)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: ResponsiveHelper.width(4, context),
                      right: ResponsiveHelper.width(4, context),
                      top: ResponsiveHelper.height(5, context),
                    ),
                    child: Container(
                      width: ResponsiveHelper.width(373, context),
                      height: 182,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: ResponsiveHelper.width(9, context),
                                vertical: ResponsiveHelper.height(11, context)),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 24,
                                  foregroundImage: NetworkImage(
                                      'https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
                                  backgroundColor: Colors.red,
                                ),
                                SizedBox(
                                  width: ResponsiveHelper.width(4, context),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            overflow: TextOverflow.ellipsis,
                                            jobOffer.title ?? "no title",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            "${jobOffer.salary}/Day",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height:
                                            ResponsiveHelper.height(5, context),
                                      ),
                                      Row(
                                        children: [
                                          Flexible(
                                            child: Container(
                                              constraints: BoxConstraints(
                                                maxWidth: ResponsiveHelper.width(
                                                    180,
                                                    context), // Adjust this value
                                              ),
                                              child: RichText(
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 3,
                                                text: TextSpan(
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: 'Lulu HyperMarket',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: ' • ',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: 'Edapally',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                          Container(
                                            height: ResponsiveHelper.height(
                                                22, context),
                                            width: ResponsiveHelper.width(
                                                110, context),
                                            decoration: BoxDecoration(
                                              color: ColorConstants.lightred,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Only for 2 days",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    color: ColorConstants
                                                        .daysleftRed,
                                                    fontSize: 12),
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

                          // Add the job details containers here (inside the white container)
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: ResponsiveHelper.width(11, context),
                                vertical: ResponsiveHelper.height(8, context)),
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      // Salary container
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: ResponsiveHelper.width(
                                                3, context),
                                            vertical: ResponsiveHelper.height(
                                                8, context)),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(24),
                                          border: Border.all(
                                              color: Colors.grey.shade300),
                                        ),
                                        child: Text(
                                          "₹1500-2000 Per Day",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),

                                      Text(" • ",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey)),

                                      // Full-Time container
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: ResponsiveHelper.width(
                                                3, context),
                                            vertical: ResponsiveHelper.height(
                                                8, context)),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(24),
                                          border: Border.all(
                                              color: Colors.grey.shade300),
                                        ),
                                        child: Row(
                                          children: [
                                            Image.asset('assets/fulltime.png'),
                                            SizedBox(
                                                width: ResponsiveHelper.width(
                                                    4, context)),
                                            Text(
                                              "Full-Time",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                      ),

                                      Text(" • ",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey)),

                                      // Onsite container
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: ResponsiveHelper.width(
                                                5, context),
                                            vertical: ResponsiveHelper.height(
                                                8, context)),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(24),
                                          border: Border.all(
                                              color: Colors.grey.shade300),
                                        ),
                                        child: Row(
                                          children: [
                                            Image.asset('assets/onsite.png'),
                                            SizedBox(
                                                width: ResponsiveHelper.width(
                                                    4, context)),
                                            Text(
                                              "Onsite",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                      ),

                                      SizedBox(width: 2),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  // +5 container
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            ResponsiveHelper.width(15, context),
                                        vertical: ResponsiveHelper.height(
                                            8, context)),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(24),
                                      border: Border.all(
                                          color: Colors.grey.shade300),
                                    ),
                                    child: Text(
                                      "+5",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
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
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: ResponsiveHelper.width(11, context),
                      vertical: ResponsiveHelper.height(11, context)),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/clock.png',
                        height: ResponsiveHelper.height(18, context),
                        width: ResponsiveHelper.width(18, context),
                      ),
                      SizedBox(
                        width: ResponsiveHelper.width(5, context),
                      ),
                      Text(
                        "30 min ago",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w400),
                      ),
                      Text("  •  ",
                          style: TextStyle(fontSize: 13, color: Colors.grey)),
                      Image.asset(
                        'assets/applicants.png',
                        height: ResponsiveHelper.height(18, context),
                        width: ResponsiveHelper.width(18, context),
                      ),
                      SizedBox(
                        width: ResponsiveHelper.width(5, context),
                      ),
                      Text(
                        "23 Applicants",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
