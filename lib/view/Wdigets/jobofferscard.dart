import 'package:flutter/material.dart';
import 'package:workwista/view/Model/job_item_model.dart';
import 'package:workwista/view/responsive_helper.dart';

class JobOffersCard extends StatelessWidget {
  const JobOffersCard({
    super.key,
    required this.jobItem,
  });

  final JobItem jobItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      width: 373,
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color(0xffDAE1E7), width: 1.5),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(
                left: 4,
                right: 4,
                top: 5,
              ),
              child: Container(
                width: 373,
                height: 140,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xff2B6699),
                    width: 1,
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 9, vertical: 11),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            foregroundImage: NetworkImage(
                                'https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
                            backgroundColor: Colors.red,
                          ),
                          SizedBox(width: 4),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      overflow: TextOverflow.ellipsis,
                                      jobItem.title ?? "No title",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      "${jobItem.salary ?? 'N/A'}/Day",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Text(
                                      "Lulu Hyoermarket",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Spacer(),
                                    Container(
                                      height: 22,
                                      width: 110,
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
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 13, vertical: 8),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: ResponsiveHelper.width(2, context),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 3, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(9),
                                    border:
                                        Border.all(color: Color(0xffCED7DE)),
                                  ),
                                  child: Text(
                                    "₹ ${jobItem.salary ?? 'N/A'} Per Day",
                                    style: TextStyle(
                                        color: Color(0xff0A0A0B),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                Text(" • ",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xff0A0A0B))),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 3, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(9),
                                    border:
                                        Border.all(color: Color(0xffCED7DE)),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.access_time,
                                        size: 16,
                                        color: Color(0xff0A0A0B),
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        "Full-Time",
                                        style: TextStyle(
                                            color: Color(0xff0A0A0B),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(" • ",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xff0A0A0B))),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(9),
                                    border:
                                        Border.all(color: Color(0xffCED7DE)),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        size: 16,
                                        color: Color(0xff0A0A0B),
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        "Onsite",
                                        style: TextStyle(
                                            color: Color(0xff0A0A0B),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: ResponsiveHelper.width(5, context),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          ResponsiveHelper.width(7, context),
                                      vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(9),
                                    border:
                                        Border.all(color: Color(0xffCED7DE)),
                                  ),
                                  child: Text(
                                    "+5",
                                    style: TextStyle(
                                        color: Color(0xff0A0A0B),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
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
            padding: EdgeInsets.symmetric(horizontal: 11, vertical: 11),
            child: Row(
              children: [
                Icon(Icons.access_time_filled, size: 18),
                SizedBox(width: 5),
                Text(
                  "30 min ago",
                  style: TextStyle(
                      color: Color(0xff4A5E6D),
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
                Text("  •  ",
                    style: TextStyle(fontSize: 13, color: Color(0xff4A5E6D))),
                Icon(Icons.people, size: 18),
                SizedBox(width: 5),
                Text(
                  "23 Applicants",
                  style: TextStyle(
                      color: Color(0xff4A5E6D),
                      fontSize: 12,
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
