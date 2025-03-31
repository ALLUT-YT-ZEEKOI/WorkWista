import 'package:flutter/material.dart';
import 'package:workwista/view/responsive_helper.dart';

class GreenCard extends StatelessWidget {
  const GreenCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 11, vertical: 17),
        decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
              fit: BoxFit.cover,
              alignment: Alignment(0, 0),
              image: AssetImage('assets/cardbg.png')),
          borderRadius: BorderRadius.circular(32),
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
                ),
                SizedBox(
                  width: ResponsiveHelper.width(12, context),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Noglet Technologies",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.pin_drop_outlined,
                          color: Colors.white,
                          size: 20,
                        ),
                        Text(
                          "Ernakulam",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
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
              height: ResponsiveHelper.height(20, context),
            ),
            Text(
              "Typing jobs",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            ),
            Text(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit.amet, consectetur adipiscing elit.ipsum dolor sit amet,",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: ResponsiveHelper.height(20, context),
            ),
            Row(
              children: [
                SizedBox(
                  width: ResponsiveHelper.width(10, context),
                ),
                Image(
                    height: ResponsiveHelper.height(18, context),
                    width: ResponsiveHelper.width(18, context),
                    image: AssetImage('assets/flag_white.png')),
                SizedBox(
                  width: ResponsiveHelper.width(3, context),
                ),
                Text(
                  "Remote",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  width: ResponsiveHelper.width(15, context),
                ),
                Text(
                  "•",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: ResponsiveHelper.width(15, context),
                ),
                Image(
                    height: ResponsiveHelper.height(18, context),
                    width: ResponsiveHelper.width(18, context),
                    image: AssetImage('assets/flag_white.png')),
                SizedBox(
                  width: ResponsiveHelper.width(3, context),
                ),
                Text(
                  "Part Time",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  width: ResponsiveHelper.width(15, context),
                ),
                Text(
                  "•",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: ResponsiveHelper.width(15, context),
                ),
                Text(
                  "Rs 1000-10000",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
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
