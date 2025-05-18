import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:workwista/view/Controllers/jobs_screen_controller.dart';
import 'package:workwista/view/Wdigets/jobofferscard.dart';
import 'package:workwista/view/Wdigets/recent_search_helper.dart';
import 'package:workwista/view/Wdigets/search_field.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  late FocusNode _searchFocusNode;
  List<String> recentSearches = [];

  @override
  void initState() {
    super.initState();
    _searchFocusNode = FocusNode();
    _loadRecentSearches();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchFocusNode.requestFocus();
    });
  }

  Future<void> _loadRecentSearches() async {
    recentSearches = await RecentSearchHelper.getRecentSearches();
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _handleSearch(String query) async {
    if (query.isEmpty) return;
    
    await RecentSearchHelper.addRecentSearch(query);
    _loadRecentSearches(); // Refresh recent searches
    
    final controller = Provider.of<JobsScreenController>(context, listen: false);
    controller.searchJobs(query);
  }

  void _removeRecentSearch(String query) async {
    await RecentSearchHelper.removeRecentSearch(query);
    _loadRecentSearches(); // Refresh recent searches
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Jobs"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            SearchField(
              height: 50,
              controller: _searchController,
              focusNode: _searchFocusNode,
              onChanged: (value) {
                if (value.length >= 2) {
                  _handleSearch(value);
                }
              },
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  _handleSearch(value);
                }
              },
            ),
            const SizedBox(height: 16),
            // Recent Searches Section
            if (recentSearches.isNotEmpty && _searchController.text.isEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0, bottom: 8),
                    child: Text(
                      'Recent Searches',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  ...recentSearches.map((search) => ListTile(
                    leading: const Icon(Icons.history),
                    title: Text(search),
                    trailing: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => _removeRecentSearch(search),
                    ),
                    onTap: () {
                      _searchController.text = search;
                      _handleSearch(search);
                      _searchFocusNode.unfocus();
                    },
                  )).toList(),
                  const Divider(),
                ],
              ),
            // Search Results Section
            Expanded(
              child: Consumer<JobsScreenController>(
                builder: (context, controller, child) {
                  if (controller.isloading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  
                  if (_searchController.text.isEmpty) {
                    return const Center(
                      child: Text("Search for jobs by title"),
                    );
                  }
                  
                  if (controller.jobsList.isEmpty) {
                    return Center(
                      child: Text("No jobs found for '${_searchController.text}'"),
                    );
                  }
                  
                  return ListView.builder(
                    itemCount: controller.SjobsList.length,
                    itemBuilder: (context, index) {
                      return JobOffersCard(
                        jobItem: controller.SjobsList[index],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}