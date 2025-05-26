import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:workwista/view/Controllers/jobs_screen_controller.dart';
import 'package:workwista/view/Wdigets/recent_category_search_helper.dart';
import 'package:workwista/view/Wdigets/search_field.dart';
import 'package:workwista/view/loginScreens/homeScreens/categories_screen.dart';
import 'package:workwista/view/loginScreens/homeScreens/selected_category_jobs_screen.dart';

class CategorySearchScreen extends StatefulWidget {
  const CategorySearchScreen({super.key});

  @override
  State<CategorySearchScreen> createState() => _CategorySearchScreenState();
}

class _CategorySearchScreenState extends State<CategorySearchScreen> {
  final TextEditingController _categorySeachController =
      TextEditingController();
  late FocusNode _categorySeachFocusNode;
  List<String> recentCategorySearches = [];

  @override
  void initState() {
    super.initState();
    _categorySeachFocusNode = FocusNode();
    _loadRecentCategorySearches();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _categorySeachFocusNode.requestFocus();
    });
  }

  Future<void> _loadRecentCategorySearches() async {
    recentCategorySearches =
        await RecentCategorySearchHelper.getRecentCategorySearches();
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _categorySeachController.dispose();
    _categorySeachFocusNode.dispose();
    super.dispose();
  }

  void _handleCategorySearch(String query) async {
    if (query.isEmpty) return;

    await RecentCategorySearchHelper.addRecentCategorySearch(query);
    _loadRecentCategorySearches(); //refresh recent searches

    final controller =
        Provider.of<JobsScreenController>(context, listen: false);
    controller.searchCategories(query);
  }

  void _removeRecentCategorySearch(String query) async {
    await RecentCategorySearchHelper.removeRecentCategorySearch(query);
    _loadRecentCategorySearches(); // Refresh recent searches
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Jobs"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Column(
          children: [
            SearchField(
              height: 50.h,
              controller: _categorySeachController,
              focusNode: _categorySeachFocusNode,
              onChanged: (value) {
                if (value.length >= 2) {
                  _handleCategorySearch(value);
                }
              },
              onSubmitted: (Value) {
                if (Value.isNotEmpty) {
                  _handleCategorySearch(Value);
                }
              },
            ),
            SizedBox(
              height: 16.h,
            ),
            //Recent category seaches section

            if (recentCategorySearches.isNotEmpty &&
                _categorySeachController.text.isEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8.w, bottom: 8.h),
                    child: Text(
                      "Recent Searches",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.sp),
                    ),
                  ),
                  ...recentCategorySearches
                      .map((search) => ListTile(
                            leading: Icon(Icons.history),
                            title: Text(search),
                            trailing: IconButton(
                              onPressed: () =>
                                  _removeRecentCategorySearch(search),
                              icon: Icon(Icons.close),
                            ),
                            onTap: () {
                              _categorySeachController.text = search;
                              _handleCategorySearch(search);
                              _categorySeachFocusNode.unfocus();
                            },
                          ))
                      .toList(),
                  Divider(),
                ],
              ),
            //category Searc hresult section

            Expanded(child: Consumer<JobsScreenController>(
              builder: (context, controller, child) {
                if (controller.isloading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (_categorySeachController.text.isEmpty) {
                  return Center(
                    child: Text("Search for categories"),
                  );
                }

                if (controller.SCategoryList.isEmpty) {
                  return Center(
                    child: Text(
                        "No categories found for '${_categorySeachController.text}"),
                  );
                }

                return GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8.h,
                    crossAxisSpacing: 8.h,
                    childAspectRatio:
                        1.673, // Adjust this value for height/width ratio
                  ),
                  itemCount: controller.SCategoryList.length,
                  itemBuilder: (context, index) {
                    final CategoryItem = controller.SCategoryList[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SelectedCategoryJobsScreen(
                                  categoryId: CategoryItem.id,
                                  selectedCategory:
                                      CategoryItem.title ?? "unnamed"),
                            ));
                      },
                      child: SizedBox(
                          width: 182.w,
                          height: 170.h,
                          child: CaetgoriesCard(category: CategoryItem)),
                    );
                  },
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
