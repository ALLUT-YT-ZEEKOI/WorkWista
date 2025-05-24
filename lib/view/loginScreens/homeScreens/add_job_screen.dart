import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:workwista/Utils/color_constants.dart';
import 'package:workwista/view/Controllers/jobs_screen_controller.dart';
import 'package:workwista/view/Wdigets/search_field.dart';

import 'package:workwista/view/loginScreens/homeScreens/Enter_job_details_screen.dart';

class AddJobScreen extends StatefulWidget {
  const AddJobScreen({super.key});

  @override
  State<AddJobScreen> createState() => _AddJobScreenState();
}

class _AddJobScreenState extends State<AddJobScreen> {
  @override
  void initState() {
    super.initState();

    // Delay getCategories() until after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller =
          Provider.of<JobsScreenController>(context, listen: false);
      controller.getCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<JobsScreenController>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0, // remove shadow
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Add Job",
          style: TextStyle(
              color: Colors.black,
              fontSize: 24.sp,
              fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 24.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 0.h,
              ),
              child: SearchField(
                  onChanged: (query) => controller.filterCategories(query),
                  height: 50.h),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 0.w,
                vertical: 0.h,
              ),
              child: controller.isloading
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height *
                          0.6, // Take most of the screen height
                      child: Center(child: CircularProgressIndicator()))
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: controller.filteredCategories.map((category) {
                        return InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EnterJobDetailsScreen(
                                    category_id: category.id,
                                  ),
                                ));
                          },
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Container(
                              width: double.infinity,
                              // margin: EdgeInsets.only(
                              //     bottom: ResponsiveHelper.height(1, context)),
                              padding: EdgeInsets.all(13),
                              decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1.w,
                                        color: ColorConstants.containerBorder)),
                                color: Colors.white,
                                boxShadow: [],
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  category.title ?? 'Unnamed Category',
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
