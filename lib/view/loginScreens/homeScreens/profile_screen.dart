import 'package:flutter/material.dart';
import 'package:workwista/Utils/color_constants.dart';
import 'package:workwista/view/responsive_helper.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 22,
            ),
            Center(
              child: Container(
                width: ResponsiveHelper.width(372, context),
                height: ResponsiveHelper.height(205, context),
                decoration: BoxDecoration(
                    border:
                        Border.all(width: 1, color: ColorConstants.descText),
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.white),
                child: Column(
                  children: [
                    SizedBox(
                      height: ResponsiveHelper.height(19, context),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 25,
                    ),
                    SizedBox(
                      height: ResponsiveHelper.height(16, context),
                    ),
                    Text(
                      "David Jhon robert",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Software Developer",
                          style: TextStyle(
                              color: ColorConstants.descText,
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        ),
                        SizedBox(
                          width: ResponsiveHelper.width(10, context),
                        ),
                        CircleAvatar(
                          radius: 3,
                          backgroundColor: ColorConstants.descText,
                        ),
                        SizedBox(
                          width: ResponsiveHelper.width(10, context),
                        ),
                        Text(
                          "Amazone",
                          style: TextStyle(
                              color: ColorConstants.descText,
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: ResponsiveHelper.height(13, context),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ResponsiveHelper.width(10, context)),
                      child: Divider(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "davidjhonro@gmail.com",
                          style: TextStyle(
                              color: ColorConstants.descText,
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        ),
                        SizedBox(
                          width: ResponsiveHelper.width(10, context),
                        ),
                        SizedBox(
                          width: ResponsiveHelper.width(10, context),
                        ),
                        Text(
                          "+91 5688656535",
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: ResponsiveHelper.height(29, context),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveHelper.width(10, context)),
              child: Text(
                "Accounts",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Center(
              child: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: ResponsiveHelper.height(16, context),
                      horizontal: ResponsiveHelper.width(12, context)),
                  width: ResponsiveHelper.width(372, context),
                  height: ResponsiveHelper.height(435, context),
                  decoration: BoxDecoration(
                      border:
                          Border.all(width: 1, color: ColorConstants.descText),
                      borderRadius: BorderRadius.circular(14),
                      color: Colors.white),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(33),
                                color: ColorConstants.containerwhite),
                            child: Icon(
                              Icons.person_outlined,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Location,Address",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Divider(
                        thickness: 2,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(33),
                                color: ColorConstants.containerwhite),
                            child: Icon(
                              Icons.email_outlined,
                              size: 22,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Email",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          Spacer(),
                          Text(
                            "verify",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Divider(
                        thickness: 2,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(33),
                                color: ColorConstants.containerwhite),
                            child: Icon(
                              Icons.person_outline,
                              size: 22,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Age",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          Spacer(),
                          Text(
                            "26Y/O",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Divider(
                        thickness: 2,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(33),
                                color: ColorConstants.containerwhite),
                            child: Icon(
                              Icons.language,
                              size: 22,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Language",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          Spacer(),
                          Text(
                            "Malayalam",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Divider(
                        thickness: 2,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(33),
                                color: ColorConstants.containerwhite),
                            child: Icon(
                              Icons.business_center_outlined,
                              size: 22,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Profession",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          Spacer(),
                          Text(
                            "Software developer",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Divider(
                        thickness: 2,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(33),
                                color: ColorConstants.containerwhite),
                            child: Icon(
                              Icons.exit_to_app,
                              size: 22,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Logout",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                          )
                        ],
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
