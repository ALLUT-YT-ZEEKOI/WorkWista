import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:workwista/Utils/color_constants.dart';
import 'package:workwista/view/Wdigets/companiescard.dart';
import 'package:workwista/view/Wdigets/greencard.dart';
import 'package:workwista/view/Wdigets/jobofferscard.dart';
import 'package:workwista/view/responsive_helper.dart';

class JobCategoryScreen extends StatelessWidget {
  final String? categoryId;
  
  const JobCategoryScreen({Key? key, this.categoryId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController _controller = PageController();
    final int _numPages = 3;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // JobOffersCard with filtered jobs
        JobOffersCard(
          context: context,
          numOfcards: 5,
          categoryId: categoryId,
        ),
        SizedBox(
          height: ResponsiveHelper.height(30, context),
        ),
        Row(
          children: [
            Text(
              "Companies nearby",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
            Spacer(),
            Text(
              "View More",
              style: TextStyle(
                  color: ColorConstants.viewMoreText,
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
        SizedBox(
          height: ResponsiveHelper.height(18, context),
        ),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 150,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  separatorBuilder: (context, index) => Container(
                    width: ResponsiveHelper.width(5, context),
                    color: Colors.transparent,
                  ),
                  itemBuilder: (context, index) {
                    return CompaniesCard();
                  },
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: ResponsiveHelper.height(22, context),
        ),
        SizedBox(
          height: 200,
          child: PageView(
            controller: _controller,
            children: [
              GreenCard(),
              GreenCard(),
              GreenCard(),
            ],
          ),
        ),
        SizedBox(
          height: ResponsiveHelper.height(10, context),
        ),
        Center(
          child: SmoothPageIndicator(
            controller: _controller,
            count: _numPages,
            effect: WormEffect(
              dotHeight: screenHeight * 0.020,
              dotWidth: screenWidth * 0.016,
              activeDotColor: Colors.black,
              dotColor: Colors.black,
            ),
          ),
        ),
        SizedBox(
          height: 50,
        )
      ],
    );
  }
}