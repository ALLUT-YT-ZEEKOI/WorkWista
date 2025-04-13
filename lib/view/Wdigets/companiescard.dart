import 'package:flutter/material.dart';
import 'package:workwista/Utils/color_constants.dart';

import 'package:workwista/view/responsive_helper.dart';

class CompaniesCard extends StatelessWidget {
  const CompaniesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.width(5, context),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.width(10, context),
        vertical: ResponsiveHelper.height(14, context),
      ),
      height: 150,
      width: ResponsiveHelper.width(250, context),
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorConstants.containerBorder,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                foregroundImage: NetworkImage(
                    'https://images.pexels.com/photos/269077/pexels-photo-269077.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
                backgroundColor: Colors.amberAccent,
              ),
              SizedBox(
                width: ResponsiveHelper.width(4, context),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Noglet Constructions",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  Text("Kochi",
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w400)),
                ],
              )
            ],
          ),
          SizedBox(
            height: ResponsiveHelper.height(12, context),
          ),
          Text("Construction Works",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
          SizedBox(
            height: ResponsiveHelper.height(14, context),
          ),
          Row(
            children: [
              Image.asset(
                'assets/fulltime2.png',
                height: ResponsiveHelper.height(15, context),
                width: ResponsiveHelper.width(15, context),
              ),
              SizedBox(
                width: ResponsiveHelper.width(5, context),
              ),
              Text("Full-Time")
            ],
          ),
        ],
      ),
    );
  }
}
