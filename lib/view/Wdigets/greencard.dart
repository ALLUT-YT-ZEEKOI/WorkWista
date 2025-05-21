import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:workwista/view/responsive_helper.dart';

class GreenCard extends StatelessWidget {
  const GreenCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 17.h),
        decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
              fit: BoxFit.cover,
              alignment: Alignment(0, 0),
              image: AssetImage('assets/cardbg.png')),
          borderRadius: BorderRadius.circular(32.w),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 24.w,
                  foregroundImage: NetworkImage(
                      'https://images.pexels.com/photos/269077/pexels-photo-269077.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
                ),
                SizedBox(
                  width: 12.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Noglet Technologies",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.pin_drop_outlined,
                          color: Colors.white,
                          size: 20.w,
                        ),
                        Text(
                          "Ernakulam",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    )
                  ],
                ),
                Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                )
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              "Typing jobs",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700),
            ),
            Text(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit.amet, consectetur adipiscing elit.ipsum dolor sit amet,",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: 10.w,
                ),
                Image(
                    height: 18.h,
                    width: 18.w,
                    image: AssetImage('assets/flag_white.png')),
                SizedBox(
                  width: 3.w,
                ),
                Text(
                  "Remote",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  width: 15.w,
                ),
                Text(
                  "•",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 15.w,
                ),
                Image(
                    height: 18.h,
                    width: 18.w,
                    image: AssetImage('assets/flag_white.png')),
                SizedBox(
                  width: 3.w,
                ),
                Text(
                  "Part Time",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  width: 15.w,
                ),
                Text(
                  "•",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 15.w,
                ),
                Text(
                  "Rs 1000-10000",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
