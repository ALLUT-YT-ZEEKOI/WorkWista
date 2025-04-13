// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:workwista/view/Controllers/jobs_screen_controller.dart';
// import 'package:workwista/view/responsive_helper.dart';

// class CustomTabBar extends StatefulWidget {
//   final TabController tabController;
//   final Function(int) onTabChanged;
//   final int currentIndex;
//   final Color color;
//   final double paddingwidth;
//   final BuildContext context;

//   const CustomTabBar({
//     super.key,
//     required this.paddingwidth,
//     required this.color,
//     required this.tabController,
//     required this.onTabChanged,
//     required this.currentIndex,
//     required this.context,
//   });

//   @override
//   State<CustomTabBar> createState() => _CustomTabBarState();
// }

// class _CustomTabBarState extends State<CustomTabBar> {
//   @override
//   void initState() {
//     super.initState();
//     // Fetch categories when the tab bar initializes
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<JobsScreenController>(widget.context, listen: false)
//           .getCategories();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final controller = Provider.of<JobsScreenController>(context);

//     // Show loading indicator while fetching categories
//     if (controller.isloading) {
//       return Center(child: CircularProgressIndicator());
//     }

//     // Show error message if no categories available
//     if (controller.categoriesList.isEmpty) {
//       return Center(child: Text("No categories available"));
//     }

//     return Container(
//       padding: EdgeInsets.symmetric(
//         horizontal: ResponsiveHelper.width(widget.paddingwidth, context),
//       ),
//       height: ResponsiveHelper.height(35, context),
//       child: TabBar(
//         tabAlignment: TabAlignment.start,
//         controller: widget.tabController,
//         isScrollable: true,
//         labelColor: widget.color,
//         unselectedLabelColor: Colors.grey,
//         labelStyle: TextStyle(
//           fontWeight: FontWeight.bold,
//           fontSize: screenWidth * 0.04,
//         ),
//         unselectedLabelStyle: TextStyle(
//           fontWeight: FontWeight.bold,
//           fontSize: screenWidth * 0.04,
//         ),
//         indicatorSize: TabBarIndicatorSize.tab,
//         indicator: BoxDecoration(
//           borderRadius: BorderRadius.circular(20),
//           border: Border.all(
//             color: widget.color,
//             width: 2,
//           ),
//         ),
//         dividerColor: Colors.transparent,
//         splashFactory: NoSplash.splashFactory,
//         overlayColor: WidgetStateProperty.all(Colors.transparent),
//         onTap: widget.onTabChanged,
//         tabs: [
//           // "All" tab (optional)
//           Tab(
//             child: Padding(
//               padding: EdgeInsets.symmetric(
//                 horizontal: ResponsiveHelper.width(12, context),
//                 vertical: ResponsiveHelper.height(7, context),
//               ),
//               child: Text("All"),
//             ),
//           ),
//           // Dynamic tabs from categories
//           ...controller.categoriesList.map((category) {
//             return Tab(
//               child: Padding(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: ResponsiveHelper.width(12, context),
//                   vertical: ResponsiveHelper.height(7, context),
//                 ),
//                 child: Text(category.title ?? "Unnamed"),
//               ),
//             );
//           }).toList(),
//         ],
//       ),
//     );
//   }
// }