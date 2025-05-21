import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workwista/Utils/color_constants.dart';

class CompaniesCard extends StatelessWidget {
  const CompaniesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 5.w,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 14.h,
      ),
      height: 150.h,
      width: 250.w,
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorConstants.containerBorder,
          width: 2.w,
        ),
        borderRadius: BorderRadius.circular(15.w),
        color: Colors.white,
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
                backgroundColor: Colors.amberAccent,
              ),
              SizedBox(
                width: 4.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Noglet Constructions",
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                  ),
                  Text("Kochi",
                      style: TextStyle(
                          fontSize: 13.sp, fontWeight: FontWeight.w400)),
                ],
              )
            ],
          ),
          SizedBox(
            height: 12.h,
          ),
          Text("Construction Works",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700)),
          SizedBox(
            height: 11.h,
          ),
          Row(
            children: [
              Image.asset(
                'assets/fulltime2.png',
                height: 15.h,
                width: 15.w,
              ),
              SizedBox(
                width: 5.w,
              ),
              Text("Full-Time")
            ],
          ),
        ],
      ),
    );
  }
}
