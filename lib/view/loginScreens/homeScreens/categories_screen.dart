import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workwista/view/Controllers/jobs_screen_controller.dart';

import 'package:workwista/view/Wdigets/search_field.dart';
import 'package:workwista/view/loginScreens/homeScreens/selected_category_jobs_screen.dart';
import 'package:workwista/view/responsive_helper.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {

  int _currentIndex = 0;

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
      appBar: AppBar(
        titleTextStyle: TextStyle(
            color: Colors.black, fontSize: 24, fontWeight: FontWeight.w700),
        title: Text("Job Categories"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: ResponsiveHelper.width(10, context), vertical: 18),
        child: SingleChildScrollView(
          child: Column(
            children: [
              searchField(height: 50),
              SizedBox(
                height: 23,
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
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 8,
                  childAspectRatio:
                      1.31, // Adjust this value for height/width ratio
                ),
                itemCount: controller.categoriesList.length,
                itemBuilder: (context, index) {
                  final category = controller.categoriesList[index];
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
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.all(8),
                          child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                category.title ?? "UnNamed",
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ))),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
