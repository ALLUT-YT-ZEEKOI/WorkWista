import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workwista/Utils/color_constants.dart';
import 'package:workwista/view/Controllers/profile_screen_controller.dart';
import 'package:workwista/view/loginScreens/sign_in_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await context.read<ProfileScreenController>().getProfileDetails();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ProfileScreenController>();

    //show loading
    if (controller.isloading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    //show error if no data
    if (controller.ProfileDetails == null) {
      return Center(
        child: Text("Failed to load profile details"),
      );
    }

    final profile = controller.ProfileDetails!.data;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24.sp),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 22.h,
              ),
              Center(
                child: Container(
                  width: 372.w,
                  height: 205.h,
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 1.w, color: ColorConstants.descText),
                      borderRadius: BorderRadius.circular(14.r),
                      color: Colors.white),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 18.h,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 26.r,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 25.r,
                          child: Icon(
                            Icons.person,
                            size: 40,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Text(
                        profile?.name ?? "not found",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.sp,
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
                                fontSize: 14.sp),
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          CircleAvatar(
                            radius: 3.r,
                            backgroundColor:
                                // ignore: deprecated_member_use
                                ColorConstants.descText.withOpacity(0.7),
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          Text(
                            "Amazone",
                            style: TextStyle(
                                color: ColorConstants.descText,
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 18.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Divider(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            profile?.email ?? "",
                            style: TextStyle(
                                color: ColorConstants.descText,
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp),
                          ),
                          SizedBox(
                            width: 23.w,
                          ),
                          Text(
                            "+91 ${profile?.phoneNumber ?? ""}",
                            style: TextStyle(
                                color: ColorConstants.descText,
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 29.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Text(
                  "Accounts",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Center(
                child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
                    width: 374.w,
                    height: 415.h,
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 1.w, color: ColorConstants.descText),
                        borderRadius: BorderRadius.circular(12.r),
                        color: Colors.white),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 36.w,
                              height: 36.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(33.r),
                                  color: Color(0xffDAE1E7)),
                              child: Icon(
                                Icons.person_outlined,
                                color: Color(0xff92A5B5),
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              "Location,Address",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 20.w,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Divider(
                          thickness: 2.h,
                        ),
                        Row(
                          children: [
                            Container(
                              width: 36.w,
                              height: 36.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(33.r),
                                  color: Color(0xffDAE1E7)),
                              child: Icon(
                                Icons.email_outlined,
                                size: 22,
                                color: Color(0xff92A5B5),
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              "Email",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                            Spacer(),
                            Text(
                              "verify",
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 20.w,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Divider(
                          thickness: 2.h,
                        ),
                        Row(
                          children: [
                            Container(
                              width: 36.w,
                              height: 36.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(33.r),
                                  color: Color(0xffDAE1E7)),
                              child: Icon(
                                Icons.person_outline,
                                size: 22,
                                color: Color(0xff92A5B5),
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              "Age",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                            Spacer(),
                            Text(
                              profile?.dob.toString() ?? "",
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 20.w,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Divider(
                          thickness: 2.h,
                        ),
                        Row(
                          children: [
                            Container(
                              width: 36.w,
                              height: 36.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(33.r),
                                  color: Color(0xffDAE1E7)),
                              child: Icon(
                                Icons.language,
                                size: 22,
                                color: Color(0xff92A5B5),
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              "Language",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                            Spacer(),
                            Text(
                              "Malayalam",
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 20.w,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Divider(
                          thickness: 2.h,
                        ),
                        Row(
                          children: [
                            Container(
                              width: 36.w,
                              height: 36.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(33.r),
                                  color: Color(0xffDAE1E7)),
                              child: Icon(
                                Icons.business_center_outlined,
                                size: 22,
                                color: Color(0xff92A5B5),
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              "Profession",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                            Spacer(),
                            Text(
                              "Software developer",
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 20.w,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Divider(
                          thickness: 2.h,
                        ),
                        InkWell(
                          onTap: () async {
                            // Clear tokens from SharedPreferences
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            await prefs.setString("access", "");
                            await prefs.setString("refresh", "");

                            // Navigate to login screen and prevent going back
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignInScreen()),
                              (Route<dynamic> route) =>
                                  false, // Remove all routes
                            );
                          },
                          child: Row(
                            children: [
                              Container(
                                width: 36.w,
                                height: 36.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(33.r),
                                    color: Color(0xffDAE1E7)),
                                child: Icon(
                                  Icons.exit_to_app,
                                  size: 22,
                                  color: Color(0xff92A5B5),
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                "Logout",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                              Spacer(),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 20.w,
                              )
                            ],
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
