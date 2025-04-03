import 'package:flutter/material.dart';
import 'package:workwista/view/Wdigets/custom_tab_bar.dart';
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
  late TabController _CategorytabController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _CategorytabController = TabController(length: 5, vsync: this);

    // Add listener to sync tab controller with page changes
    _CategorytabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    if (_CategorytabController.indexIsChanging) {
      setState(() {
        _currentIndex = _CategorytabController.index;
      });
    }
  }

  @override
  void dispose() {
    _CategorytabController.removeListener(_handleTabSelection);
    _CategorytabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              CustomTabBar(
                  paddingwidth: 0,
                  color: Colors.orange,
                  tabController: _CategorytabController,
                  onTabChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  currentIndex: _currentIndex,
                  context: context),
              SizedBox(
                height: 16,
              ),
              Builder(
                builder: (context) {
                  switch (_currentIndex) {
                    case 0:
                      return CategoryAll();
                    case 1:
                      return CategoryIT();
                    case 2:
                      return CategoryLocalJobs();
                    case 3:
                      return CategoryRemoteJobs();
                    case 4:
                      return CategoryNewJobs();
                    default:
                      return CategoryAll();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//all category screen contents
class CategoryAll extends StatelessWidget {
  const CategoryAll({super.key});

  @override
  Widget build(BuildContext context) {
    String categoryName = "All";
    return Column(
      children: [
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 8,
            childAspectRatio: 1.31, // Adjust this value for height/width ratio
          ),
          itemCount: 21,
          itemBuilder: (context, index) {
            return SizedBox(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SelectedCategoryJobsScreen(
                          selectedCategory: categoryName,
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
                          categoryName,
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
    );
  }
}

//category it contents
class CategoryIT extends StatelessWidget {
  const CategoryIT({super.key});

  @override
  Widget build(BuildContext context) {
    String categoryName = "IT";
    return Column(
      children: [
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 8,
            childAspectRatio: 1.31, // Adjust this value for height/width ratio
          ),
          itemCount: 21,
          itemBuilder: (context, index) {
            return SizedBox(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SelectedCategoryJobsScreen(
                          selectedCategory: categoryName,
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
                          categoryName,
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
    );
  }
}

//category local jobs contents
class CategoryLocalJobs extends StatelessWidget {
  const CategoryLocalJobs({super.key});

  @override
  Widget build(BuildContext context) {
    String categoryName = "Local jobs";
    return Column(
      children: [
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 8,
            childAspectRatio: 1.31, // Adjust this value for height/width ratio
          ),
          itemCount: 21,
          itemBuilder: (context, index) {
            return SizedBox(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SelectedCategoryJobsScreen(
                          selectedCategory: categoryName,
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
                          categoryName,
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
    );
  }
}

//category remote jobs contents
class CategoryRemoteJobs extends StatelessWidget {
  const CategoryRemoteJobs({super.key});

  @override
  Widget build(BuildContext context) {
    String categoryName = "Remote Jobs";
    return Column(
      children: [
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 8,
            childAspectRatio: 1.31, // Adjust this value for height/width ratio
          ),
          itemCount: 21,
          itemBuilder: (context, index) {
            return SizedBox(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SelectedCategoryJobsScreen(
                          selectedCategory: categoryName,
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
                          categoryName,
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
    );
  }
}

//category new jobs contents
class CategoryNewJobs extends StatelessWidget {
  const CategoryNewJobs({super.key});

  @override
  Widget build(BuildContext context) {
    String categoryName = "new jobs";
    return Column(
      children: [
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 8,
            childAspectRatio: 1.31,
          ),
          itemCount: 21,
          itemBuilder: (context, index) {
            return SizedBox(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SelectedCategoryJobsScreen(
                          selectedCategory: categoryName,
                        ),
                      ));
                },
                child: Container(
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
                          categoryName,
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
    );
  }
}
