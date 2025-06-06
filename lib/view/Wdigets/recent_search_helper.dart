// utils/recent_search_helper.dart
import 'package:shared_preferences/shared_preferences.dart';

class RecentSearchHelper {
  static const String _recentSearchesKey = 'recent_searches';
  static const String _recentLocationSearchesKey = 'recent_location_searches';
  static const int _maxRecentSearches = 5;

  // Title search methods
  static Future<List<String>> getRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_recentSearchesKey) ?? [];
  }

  static Future<void> addRecentSearch(String query) async {
    if (query.trim().isEmpty) return;
    
    final prefs = await SharedPreferences.getInstance();
    List<String> searches = await getRecentSearches();
    
    // Remove if already exists
    searches.remove(query);
    // Add to beginning
    searches.insert(0, query);
    // Keep only last 5
    if (searches.length > _maxRecentSearches) {
      searches = searches.sublist(0, _maxRecentSearches);
    }
    
    await prefs.setStringList(_recentSearchesKey, searches);
  }

  static Future<void> removeRecentSearch(String query) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> searches = await getRecentSearches();
    searches.remove(query);
    await prefs.setStringList(_recentSearchesKey, searches);
  }

  // Location search methods
  static Future<List<String>> getRecentLocationSearches() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_recentLocationSearchesKey) ?? [];
  }

  static Future<void> addRecentLocationSearch(String query) async {
    if (query.trim().isEmpty) return;
    
    final prefs = await SharedPreferences.getInstance();
    List<String> searches = await getRecentLocationSearches();
    
    // Remove if already exists
    searches.remove(query);
    // Add to beginning
    searches.insert(0, query);
    // Keep only last 5
    if (searches.length > _maxRecentSearches) {
      searches = searches.sublist(0, _maxRecentSearches);
    }
    
    await prefs.setStringList(_recentLocationSearchesKey, searches);
  }

  static Future<void> removeRecentLocationSearch(String query) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> searches = await getRecentLocationSearches();
    searches.remove(query);
    await prefs.setStringList(_recentLocationSearchesKey, searches);
  }

  // Clear all recent searches
  static Future<void> clearAllRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_recentSearchesKey);
    await prefs.remove(_recentLocationSearchesKey);
  }
}