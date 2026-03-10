import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/grocery_item.dart';

class GroceryData {
  final List<GroceryItem> items;
  final Map<String, int> frequency;
  GroceryData({required this.items, required this.frequency});
}

class StorageService {
  static const _itemsKey = 'items';
  static const _frequencyKey = 'frequency';

  Future<GroceryData> loadData() async {
    final prefs = await SharedPreferences.getInstance();

    List<GroceryItem> items = [];
    Map<String, int> frequency = {};

    final itemsJson = prefs.getString(_itemsKey);
    if (itemsJson != null) {
      final List decoded = jsonDecode(itemsJson);
      items = decoded.map((e) => GroceryItem.fromJson(e)).toList();
    }

    final freqJson = prefs.getString(_frequencyKey);
    if (freqJson != null) {
      final Map decoded = jsonDecode(freqJson);
      frequency = decoded.map((k, v) => MapEntry(k.toString(), v as int));
    }

    return GroceryData(items: items, frequency: frequency);
  }

  Future<void> saveData(
      List<GroceryItem> items, Map<String, int> frequency) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        _itemsKey, jsonEncode(items.map((e) => e.toJson()).toList()));
    await prefs.setString(_frequencyKey, jsonEncode(frequency));
  }
}