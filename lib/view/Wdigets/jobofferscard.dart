import 'package:flutter/material.dart';
import 'package:workwista/view/Model/job_item_model.dart';

class JobOffersCard extends StatelessWidget {
  const JobOffersCard({
    super.key,
    required this.jobItem,
  });

  final JobItem jobItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 232,
      width: 373,
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300, width: 2),
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
                height: 182,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
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
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      "${jobItem.salary ?? 'N/A'}/Day",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Flexible(
                                      child: Container(
                                        constraints: BoxConstraints(
                                          maxWidth: 180,
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
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              TextSpan(
                                                text: ' • ',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              TextSpan(
                                                text: 'Edapally',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
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
                                      height: 22,
                                      width: 110,
                                      decoration: BoxDecoration(
                                        color: Colors.red[100],
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Only for 2 days",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: Colors.red,
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
                          EdgeInsets.symmetric(horizontal: 11, vertical: 8),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 3, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(24),
                                    border:
                                        Border.all(color: Colors.grey.shade300),
                                  ),
                                  child: Text(
                                    "${jobItem.salary ?? 'N/A'} Per Day",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                Text(" • ",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey)),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 3, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(24),
                                    border:
                                        Border.all(color: Colors.grey.shade300),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.access_time, size: 16),
                                      SizedBox(width: 4),
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
                                        fontSize: 12, color: Colors.grey)),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(24),
                                    border:
                                        Border.all(color: Colors.grey.shade300),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.location_on, size: 16),
                                      SizedBox(width: 4),
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
                            SizedBox(height: 3),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: Text(
                                "+5",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w400),
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
            padding: EdgeInsets.symmetric(horizontal: 11, vertical: 11),
            child: Row(
              children: [
                Icon(Icons.access_time, size: 18),
                SizedBox(width: 5),
                Text(
                  "30 min ago",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                ),
                Text("  •  ",
                    style: TextStyle(fontSize: 13, color: Colors.grey)),
                Icon(Icons.people, size: 18),
                SizedBox(width: 5),
                Text(
                  "23 Applicants",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
