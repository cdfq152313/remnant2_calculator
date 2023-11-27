import 'dart:convert';

import 'package:remnant2_calculator/domain/item.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ItemRepository<T extends Item> {
  ItemRepository(this._prefs) {
    _load();
  }

  final SharedPreferences _prefs;

  String get key;

  List<T> _items = [];

  T get(String key) {
    return _items.firstWhere((element) => element.name == key);
  }

  List<T> getAll() {
    return _items;
  }

  List<T> filter(String keyword) {
    return _items.where((element) => element.name.contains(keyword)).toList();
  }

  void add(T item) {
    _items.add(item);
    _save();
  }

  void remove(T item) {
    _items.remove(item);
    _save();
  }

  List<T> getDefaultItems() => [];

  void _save() {
    _prefs.setString(
      key,
      jsonEncode(_items),
    );
  }

  void _load() {
    final json = jsonDecode(_prefs.getString(key) ?? '[]') as List;
    _items = getDefaultItems();
    _items.addAll(json.map((v) => Item.fromJson(v) as T));
  }
}
