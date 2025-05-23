import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';
import 'package:workwista/view/Controllers/jobs_screen_controller.dart';
import 'package:workwista/view/Model/all_category_listing_model.dart';
import 'package:workwista/view/Wdigets/search_field.dart';
import 'package:workwista/view/loginScreens/homeScreens/category_search_screen.dart';
import 'package:workwista/view/loginScreens/homeScreens/selected_category_jobs_screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  // int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // Fetch categories when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<JobsScreenController>(context, listen: false).getCategories();
    });
  }

  @override
  void dispose() {
    super.dispose();
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
        titleTextStyle: TextStyle(
            color: Colors.black, fontSize: 24.sp, fontWeight: FontWeight.w700),
        title: Text("Job Categories"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 0.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CategorySearchScreen()),
                    );
                  },
                  child: IgnorePointer(child: SearchField(height: 50))),
              SizedBox(
                height: 23.h,
              ),
              // Show loading indicator while fetching
              if (controller.isloading)
                const Center(child: CircularProgressIndicator()),
              // Show error message if no categories available
              if (!controller.isloading && controller.categoriesList.isEmpty)
                const Center(child: Text("No categories available")),
              // Show grid when categories are loaded
              if (!controller.isloading && controller.categoriesList.isNotEmpty)
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.all(0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8.h,
                    crossAxisSpacing: 8.h,
                    childAspectRatio:
                        1.673, // Adjust this value for height/width ratio
                  ),
                  itemCount: controller.categoriesList.length,
                  itemBuilder: (context, index) {
                    final category = controller.categoriesList[index];
                    return CaetgoriesCard(category: category);
                  },
                )
            ],
          ),
        ),
      ),
    );
  }
}

class CaetgoriesCard extends StatelessWidget {
  const CaetgoriesCard({
    super.key,
    required this.category,
  });

  final AllCategories category;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SelectedCategoryJobsScreen(
                  selectedCategory: category.title ?? "unNamed",
                  categoryId: category.id, // Pass the category ID
                ),
              ));
        },
        child: Container(
            // Set your custom height here
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      'https://images.pexels.com/photos/159839/office-home-house-desk-159839.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2')),
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
            ),
            padding: EdgeInsets.all(12.w),
            child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  category.title ?? "UnNamed",
                  style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ))),
      ),
    );
  }
}
