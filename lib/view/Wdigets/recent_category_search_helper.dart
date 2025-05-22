import 'package:shared_preferences/shared_preferences.dart';

class RecentCategorySearchHelper {
  static const String _recentCategorySearchKey = 'recent_category_searches';
  static const int _maxRecentCategorySearches = 5;

  static Future<List<String>> getRecentCategorySearches() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_recentCategorySearchKey) ?? [];
  }

  static Future<void> addRecentCategorySearch(String query) async {
    if (query.trim().isEmpty) return;

    final prefs = await SharedPreferences.getInstance();
    List<String> categorysearches = await getRecentCategorySearches();

    //Remoce if already exists
    categorysearches.remove(query);
    //Add to beginning
    categorysearches.insert(0, query);

    //keep ypur only last 5
    if (categorysearches.length > _maxRecentCategorySearches) {
      categorysearches =
          categorysearches.sublist(0, _maxRecentCategorySearches);
    }
    await prefs.setStringList(_recentCategorySearchKey, categorysearches);
  }

  static Future<void> removeRecentCategorySearch(String query) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> categorysearches = await getRecentCategorySearches();
    categorysearches.remove(query);
    await prefs.setStringList(_recentCategorySearchKey, categorysearches);
  }
}
