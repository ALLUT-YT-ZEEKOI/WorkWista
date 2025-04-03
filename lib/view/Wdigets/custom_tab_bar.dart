import 'package:flutter/material.dart';
import 'package:workwista/view/responsive_helper.dart';

class CustomTabBar extends StatelessWidget {
  final TabController tabController;
  final Function(int) onTabChanged;
  final int currentIndex;
  final Color color;
  final double paddingwidth;
  final BuildContext context;

  const CustomTabBar({
    super.key,
    required this.paddingwidth,
    required this.color,
    required this.tabController,
    required this.onTabChanged,
    required this.currentIndex,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.width(paddingwidth, context),
      ),
      height: ResponsiveHelper.height(35, context),
      child: TabBar(
        tabAlignment: TabAlignment.start,
        controller: tabController,
        isScrollable: true,
        labelColor: color,
        unselectedLabelColor: Colors.grey,
        labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: screenWidth * 0.04,
        ),
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: screenWidth * 0.04,
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: color,
            width: 2,
          ),
        ),
        dividerColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        onTap: onTabChanged,
        tabs: [
          Tab(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveHelper.width(12, context),
                vertical: ResponsiveHelper.height(7, context),
              ),
              child: Text("All"),
            ),
          ),
          Tab(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveHelper.width(12, context),
                vertical: ResponsiveHelper.height(7, context),
              ),
              child: Text("IT"),
            ),
          ),
          Tab(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveHelper.width(12, context),
                vertical: ResponsiveHelper.height(7, context),
              ),
              child: Text("Local Jobs"),
            ),
          ),
          Tab(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveHelper.width(12, context),
                vertical: ResponsiveHelper.height(7, context),
              ),
              child: Text("Remote Jobs"),
            ),
          ),
          Tab(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveHelper.width(12, context),
                vertical: ResponsiveHelper.height(7, context),
              ),
              child: Text("New Jobs"),
            ),
          ),
        ],
      ),
    );
  }
}
