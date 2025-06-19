import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workwista/view/Model/job_item_model.dart';

class JobOffersCard extends StatelessWidget {
  const JobOffersCard({
    super.key,
    required this.jobItem,
  });

  final JobItem jobItem;

  @override
  Widget build(BuildContext context) {
    final imageUrl = (jobItem.job_image!.isNotEmpty)
        ? jobItem.job_image!
            .replaceFirst("http://localhost", "https://workwista.com")
        : 'https://i.ibb.co/G3fLN9bk/no-image.png';

    return Container(
      height: 173.h,
      width: 373.w,
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color(0xffDAE1E7), width: 1.5.w),
        borderRadius: BorderRadius.circular(15.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(
                left: 4.w,
                right: 4.w,
                top: 5.h,
              ),
              child: Container(
                width: 373.w,
                height: 122.h,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xff2B6699),
                    width: 1.w,
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.w),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 9.w, vertical: 11.h),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 24.w,
                            foregroundImage: NetworkImage(imageUrl),
                            backgroundColor: Colors.white,
                          ),
                          SizedBox(width: 4.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        jobItem.title ?? "No title",
                                        style: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15.w,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: '₹',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16.sp,
                                              height: 1.0,
                                              letterSpacing: 0.0,
                                              color: Colors.black,
                                            ),
                                          ),
                                          TextSpan(
                                            text: jobItem.salary_from != null
                                                ? double.tryParse(jobItem
                                                            .salary_from!)
                                                        ?.toInt()
                                                        .toString() ??
                                                    "0"
                                                : "Salary not specified",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16.sp,
                                              height: 1.0,
                                              letterSpacing: 0.0,
                                              color: Colors.black,
                                            ),
                                          ),
                                          TextSpan(
                                            text: ' - ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16.sp,
                                              height: 1.0,
                                              letterSpacing: 0.0,
                                              color: Colors.black,
                                            ),
                                          ),
                                          TextSpan(
                                            text: jobItem.salary_to != null
                                                ? double.tryParse(
                                                            jobItem.salary_to!)
                                                        ?.toInt()
                                                        .toString() ??
                                                    "0"
                                                : "Salary not specified",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16.sp,
                                              height: 1.0,
                                              letterSpacing: 0.0,
                                              color: Colors.black,
                                            ),
                                          ),
                                          TextSpan(
                                            text: '/',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16.sp,
                                              height: 1.0,
                                              letterSpacing: 0.0,
                                              color: Colors.black,
                                            ),
                                          ),
                                          TextSpan(
                                            text: 'Day',
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
                                  ],
                                ),
                                SizedBox(height: 0.h),
                                Row(
                                  children: [
                                    Text(
                                      "Lulu Hyoermarket",
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Spacer(),
                                    Container(
                                      height: 22.h,
                                      width: 110.w,
                                      decoration: BoxDecoration(
                                        color: Color(0xffFFCED3),
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Only for 2 days",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xff8C1823),
                                              fontSize: 12.sp),
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
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 13.w, vertical: 8.h),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5.w, vertical: 3.h),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(9.w),
                                        border: Border.all(
                                            color: Color(0xffCED7DE)),
                                      ),
                                      child: Row(
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: '₹',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12.sp,
                                                    height: 1.0,
                                                    letterSpacing: 0.0,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: jobItem.salary_from !=
                                                          null
                                                      ? double.tryParse(jobItem
                                                                  .salary_from!)
                                                              ?.toInt()
                                                              .toString() ??
                                                          "0"
                                                      : "Salary not specified",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12.sp,
                                                    height: 1.0,
                                                    letterSpacing: 0.0,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: ' - ',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12.sp,
                                                    height: 1.0,
                                                    letterSpacing: 0.0,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: jobItem.salary_to !=
                                                          null
                                                      ? double.tryParse(jobItem
                                                                  .salary_to!)
                                                              ?.toInt()
                                                              .toString() ??
                                                          "0"
                                                      : "Salary not specified",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12.sp,
                                                    height: 1.0,
                                                    letterSpacing: 0.0,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: ' Per ',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12.sp,
                                                    height: 1.0,
                                                    letterSpacing: 0.0,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: 'Day',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12.sp,
                                                    height: 1.5,
                                                    letterSpacing: 0.0,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )),
                                  Text(" • ",
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          color: Color(0xff0A0A0B))),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5.w, vertical: 3.h),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(9.w),
                                      border:
                                          Border.all(color: Color(0xffCED7DE)),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.access_time,
                                          size: 16.w,
                                          color: Color(0xff0A0A0B),
                                        ),
                                        SizedBox(width: 4.w),
                                        Text(
                                          "Full-Time",
                                          style: TextStyle(
                                              color: Color(0xff0A0A0B),
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(" • ",
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          color: Color(0xff0A0A0B))),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5.w, vertical: 3.h),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(9.w),
                                      border:
                                          Border.all(color: Color(0xffCED7DE)),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          size: 16.w,
                                          color: Color(0xff0A0A0B),
                                        ),
                                        SizedBox(width: 4.w),
                                        Text(
                                          "Onsite",
                                          style: TextStyle(
                                              color: Color(0xff0A0A0B),
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5.w, vertical: 3.h),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(9.w),
                                      border:
                                          Border.all(color: Color(0xffCED7DE)),
                                    ),
                                    child: Text(
                                      "+5",
                                      style: TextStyle(
                                          color: Color(0xff0A0A0B),
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
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
            padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 11.h),
            child: Row(
              children: [
                Icon(Icons.access_time_filled, size: 18.w),
                SizedBox(width: 5),
                Text(
                  "30 min ago",
                  style: TextStyle(
                      color: Color(0xff4A5E6D),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400),
                ),
                Text("  •  ",
                    style:
                        TextStyle(fontSize: 13.sp, color: Color(0xff4A5E6D))),
                Icon(Icons.people, size: 18.w),
                SizedBox(width: 5.w),
                Text(
                  "23 Applicants",
                  style: TextStyle(
                      color: Color(0xff4A5E6D),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
