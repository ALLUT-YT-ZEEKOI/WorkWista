import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:workwista/view/Controllers/jobs_screen_controller.dart';
import 'package:workwista/view/Wdigets/jobofferscard.dart';
import 'package:workwista/view/Wdigets/recent_search_helper.dart';
import 'package:workwista/view/Wdigets/search_field.dart';
import 'package:workwista/view/loginScreens/homeScreens/job_details_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  late FocusNode _searchFocusNode;
  late FocusNode _locationFocusNode;
  List<String> recentSearches = [];
  List<String> recentLocationSearches = [];
  String _currentSearchType = ''; // 'title' or 'location'

  @override
  void initState() {
    super.initState();
    _searchFocusNode = FocusNode();
    _locationFocusNode = FocusNode();
    _loadRecentSearches();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchFocusNode.requestFocus();
    });
  }

  Future<void> _loadRecentSearches() async {
    recentSearches = await RecentSearchHelper.getRecentSearches();
    recentLocationSearches =
        await RecentSearchHelper.getRecentLocationSearches();
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _searchController.dispose();
    _locationController.dispose();
    _searchFocusNode.dispose();
    _locationFocusNode.dispose();
    super.dispose();
  }

  void _handleTitleSearch(String query) async {
    if (query.isEmpty) return;

    await RecentSearchHelper.addRecentSearch(query);
    _loadRecentSearches(); // Refresh recent searches

    final controller =
        Provider.of<JobsScreenController>(context, listen: false);
    controller.searchJobs(query);
    _currentSearchType = 'title';
    setState(() {});
  }

  void _handleLocationSearch(String query) async {
    if (query.isEmpty) return;

    await RecentSearchHelper.addRecentLocationSearch(query);
    _loadRecentSearches(); // Refresh recent searches

    final controller =
        Provider.of<JobsScreenController>(context, listen: false);
    controller.searchJobsByLocation(query);
    _currentSearchType = 'location';
    setState(() {});
  }

  void _removeRecentSearch(String query) async {
    await RecentSearchHelper.removeRecentSearch(query);
    _loadRecentSearches(); // Refresh recent searches
  }

  void _removeRecentLocationSearch(String query) async {
    await RecentSearchHelper.removeRecentLocationSearch(query);
    _loadRecentSearches(); // Refresh recent searches
  }

  void _clearSearch() {
    _searchController.clear();
    _locationController.clear();
    _currentSearchType = '';
    final controller =
        Provider.of<JobsScreenController>(context, listen: false);
    controller.clearSearchResults();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Handle keyboard properly
      appBar: AppBar(
        title: Text("Search Jobs"),
        actions: [
          if (_currentSearchType.isNotEmpty)
            IconButton(
              icon: Icon(Icons.clear),
              onPressed: _clearSearch,
            ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            children: [
              // Fixed header with search fields
              Column(
                children: [
                  SizedBox(height: 8.h),
                  // Title Search Field
                  SearchField(
                    height: 50.h,
                    controller: _searchController,
                    focusNode: _searchFocusNode,
                    hintText: "Search by job title...",
                    onChanged: (value) {
                      if (value.length >= 2) {
                        _locationController.clear();
                        _handleTitleSearch(value);
                      }
                    },
                    onSubmitted: (value) {
                      if (value.isNotEmpty) {
                        _locationController.clear();
                        _handleTitleSearch(value);
                      }
                    },
                  ),
                  SizedBox(height: 12.h),

                  // Location Search Field
                  SearchField(
                    height: 50.h,
                    controller: _locationController,
                    focusNode: _locationFocusNode,
                    hintText: "Search by location...",
                    onChanged: (value) {
                      if (value.length >= 2) {
                        _searchController.clear();
                        _handleLocationSearch(value);
                      }
                    },
                    onSubmitted: (value) {
                      if (value.isNotEmpty) {
                        _searchController.clear();
                        _handleLocationSearch(value);
                      }
                    },
                  ),
                  SizedBox(height: 16.h),
                ],
              ),

              // Flexible content area
              Expanded(
                child: Column(
                  children: [
                    // Recent Searches Section - Make it scrollable to prevent overflow
                    if (_searchController.text.isEmpty &&
                        _locationController.text.isEmpty)
                      Flexible(
                        flex: 7,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Recent Title Searches
                              if (recentSearches.isNotEmpty) ...[
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 8.0.w, bottom: 8.h),
                                  child: Text(
                                    'Recent Title Searches',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                ),
                                ...recentSearches
                                    .take(
                                        5) // Limit to 3 recent searches to prevent overflow
                                    .map((search) => ListTile(
                                          dense:
                                              true, // Make tiles more compact
                                          leading: const Icon(Icons.history),
                                          title: Text(search),
                                          trailing: IconButton(
                                            icon: const Icon(Icons.close),
                                            onPressed: () =>
                                                _removeRecentSearch(search),
                                          ),
                                          onTap: () {
                                            _searchController.text = search;
                                            _locationController.clear();
                                            _handleTitleSearch(search);
                                            _searchFocusNode.unfocus();
                                            _locationFocusNode.unfocus();
                                          },
                                        ))
                                    .toList(),
                                SizedBox(height: 8.h),
                              ],

                              // Recent Location Searches
                              if (recentLocationSearches.isNotEmpty) ...[
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 8.0.w, bottom: 8.h),
                                  child: Text(
                                    'Recent Location Searches',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                ),
                                ...recentLocationSearches
                                    .take(
                                        5) // Limit to 3 recent searches to prevent overflow
                                    .map((search) => ListTile(
                                          dense:
                                              true, // Make tiles more compact
                                          leading:
                                              const Icon(Icons.location_on),
                                          title: Text(search),
                                          trailing: IconButton(
                                            icon: const Icon(Icons.close),
                                            onPressed: () =>
                                                _removeRecentLocationSearch(
                                                    search),
                                          ),
                                          onTap: () {
                                            _locationController.text = search;
                                            _searchController.clear();
                                            _handleLocationSearch(search);
                                            _searchFocusNode.unfocus();
                                            _locationFocusNode.unfocus();
                                          },
                                        ))
                                    .toList(),
                                SizedBox(height: 8.h),
                              ],

                              if (recentSearches.isNotEmpty ||
                                  recentLocationSearches.isNotEmpty)
                                const Divider(),
                            ],
                          ),
                        ),
                      ),

                    // Search Results Section
                    Expanded(
                      child: Consumer<JobsScreenController>(
                        builder: (context, controller, child) {
                          if (controller.isloading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }

                          if (_searchController.text.isEmpty &&
                              _locationController.text.isEmpty) {
                            return const Center(
                              child: Text(""),
                            );
                          }

                          List<dynamic> jobsList = controller.SjobsList;
                          String searchQuery = _currentSearchType == 'title'
                              ? _searchController.text
                              : _locationController.text;

                          if (jobsList.isEmpty) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    _currentSearchType == 'location'
                                        ? Icons.location_off
                                        : Icons.search_off,
                                    size: 64,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(height: 16.h),
                                  Text(
                                    "No jobs found for '$searchQuery'",
                                    style: TextStyle(fontSize: 16.sp),
                                  ),
                                  if (_currentSearchType == 'location')
                                    Padding(
                                      padding: EdgeInsets.only(top: 8.h),
                                      child: Text(
                                        "Try searching with a different location",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            );
                          }

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.w, vertical: 8.h),
                                child: Text(
                                  "Found ${jobsList.length} jobs ${_currentSearchType == 'location' ? 'in' : 'for'} '$searchQuery'",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: jobsList.length,
                                  itemBuilder: (context, index) {
                                    final jobItem = jobsList[index];
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  JobDetailsScreen(
                                                      jobId: jobItem.id),
                                            ));
                                      },
                                      child: JobOffersCard(
                                        jobItem: jobItem,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
