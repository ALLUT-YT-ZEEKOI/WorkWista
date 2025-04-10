import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:workwista/Utils/color_constants.dart';
import 'package:workwista/view/Wdigets/gradient_button.dart';
import 'package:workwista/view/Wdigets/jobofferscard.dart';
import 'package:workwista/view/responsive_helper.dart';

class MyJobsScreen extends StatefulWidget {
  const MyJobsScreen({super.key});

  @override
  State<MyJobsScreen> createState() => _MyJobsScreenState();
}

class _MyJobsScreenState extends State<MyJobsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          titleTextStyle: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.w700),
          title: Text("My jobs"),
          actions: [
            IconButton(
                onPressed: () {
                  log("pressed");
                },
                icon: Icon(
                  Icons.more_vert,
                  size: 26,
                ))
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: ResponsiveHelper.width(10, context),
              vertical: ResponsiveHelper.height(24, context)),
          child: Column(
            children: [
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
                        CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 24,
                        ),
                        SizedBox(
                          width: ResponsiveHelper.width(14, context),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Joseph",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "plumbing Work",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        Spacer(),
                        Column(
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 4,
                                  backgroundColor: ColorConstants.nowOnline,
                                ),
                                SizedBox(
                                  width: ResponsiveHelper.width(9, context),
                                ),
                                Text(
                                  "Online",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                            Text(
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
                    SizedBox(
                      height: 23,
                    ),
                    Row(
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
                    SizedBox(
                      height: 14,
                    ),
                    Container(
                      width: ResponsiveHelper.width(
                          double.infinity, context), // Set  width
                      height: 8, // Set  thickness
                      decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: 0.1, // Progress percentage (90% filled)
                          backgroundColor:
                              Colors.transparent, // Remove default background
                          valueColor: AlwaysStoppedAnimation<Color>(
                              ColorConstants
                                  .ProgressBarColor), // Progress bar color
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Row(
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
                    SizedBox(
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
                              shape: RoundedRectangleBorder(
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
                                    height:
                                        ResponsiveHelper.height(270, context),
                                    padding: EdgeInsets.all(16),
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
                                        SizedBox(height: 16),
                                        // Payment Icons Row
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            CircleAvatar(
                                                radius: 25,
                                                backgroundColor: ColorConstants
                                                    .indicatorBlue,
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  radius: 24,
                                                  child: Image.asset(
                                                      "assets/upi.png"),
                                                )),
                                            CircleAvatar(
                                                radius: 25,
                                                backgroundColor: ColorConstants
                                                    .indicatorBlue,
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  radius: 24,
                                                  child: Image.asset(
                                                      "assets/gpay.png"),
                                                )),
                                            CircleAvatar(
                                                radius: 25,
                                                backgroundColor: ColorConstants
                                                    .indicatorBlue,
                                                child: CircleAvatar(
                                                  backgroundColor:
                                                      ColorConstants.phonepe,
                                                  radius: 24,
                                                  child: Image.asset(
                                                      "assets/phonepe.png"),
                                                )),
                                            CircleAvatar(
                                                radius: 25,
                                                backgroundColor: ColorConstants
                                                    .indicatorBlue,
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  radius: 24,
                                                  child: Image.asset(
                                                      "assets/paytm.png"),
                                                )),
                                            CircleAvatar(
                                                radius: 25,
                                                backgroundColor: ColorConstants
                                                    .indicatorBlue,
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  radius: 24,
                                                  child: Image.asset(
                                                      "assets/bank.png"),
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 20),
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
                                                    BorderRadius.circular(15.0),
                                                borderSide: BorderSide(
                                                  color: ColorConstants
                                                      .containerBorder
                                                      .withOpacity(0.1),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 20),
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
                          width:
                              ResponsiveHelper.width(double.infinity, context)),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: ResponsiveHelper.height(14, context),
              ),
              Container(
                height: 70, // Fixed height for TabBar
                color: Colors.white, // Background color
                child: TabBar(
                  indicator: BoxDecoration(
                    color:
                        Colors.grey[200], // Background color for selected tab
                  ),
                  labelColor: Colors.black, // Selected text color
                  unselectedLabelColor: Colors.black54, // Unselected text color
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  tabs: [
                    TabItem(title: "Recent Jobs", count: "17"),
                    TabItem(title: "Posted Jobs", count: "5"),
                    TabItem(title: "Done Jobs", count: "7"),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    SingleChildScrollView(child: JobOffersCard(numOfcards: 5,context: context,)),
                    SingleChildScrollView(child: JobOffersCard(numOfcards: 5,context: context,)),
                    SingleChildScrollView(child: JobOffersCard(numOfcards: 5,context: context,)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TabItem extends StatelessWidget {
  final String title;
  final String count;

  const TabItem({required this.title, required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 124, // Fixed width
      height: 70, // Fixed height
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(count,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          SizedBox(height: 5),
          Text(title,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
