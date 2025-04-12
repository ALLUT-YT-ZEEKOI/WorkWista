import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workwista/view/Controllers/jobs_screen_controller.dart';
import 'package:workwista/view/Wdigets/search_field.dart';
import 'package:workwista/view/loginScreens/homeScreens/Enter_job_details_screen.dart';
import 'package:workwista/view/responsive_helper.dart';

class AddJobScreen extends StatefulWidget {
  const AddJobScreen({super.key});

  @override
  State<AddJobScreen> createState() => _AddJobScreenState();
}

class _AddJobScreenState extends State<AddJobScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch categories when the screen initializes
    final controller =
        Provider.of<JobsScreenController>(context, listen: false);
    controller.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<JobsScreenController>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Job",
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 25,
            ),
            Center(
              child: SizedBox(
                  width: ResponsiveHelper.width(365, context),
                  child: searchField(height: 50)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveHelper.width(25, context),
                vertical: 35,
              ),
              child: controller.isloading
                  ? CircularProgressIndicator()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: controller.categoriesList.map((category) {
                        return InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EnterJobDetailsScreen(category_id: category.id,),
                                ));
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                                bottom: ResponsiveHelper.height(1, context)),
                            padding: EdgeInsets.all(
                                ResponsiveHelper.width(12, context)),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              boxShadow: [],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              category.title ?? 'Unnamed Category',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
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
