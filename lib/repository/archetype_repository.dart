import 'dart:convert';

import 'package:remnant2_calculator/domain/item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ArchetypeRepository {
  ArchetypeRepository(this._prefs) : this._items = [] {
    _load();
  }

  final SharedPreferences _prefs;
  final String key = 'archetype';

  List<Item> _items;

  List<Item> getAll() {
    return _items;
  }

  List<Item> filter(String keyword) {
    return _items.where((element) => element.name.contains(keyword)).toList();
  }

  void add(Item item) {
    _items.add(item);
    _save();
  }

  void remove(Item item) {
    _items.remove(item);
    _save();
  }

  void _save() {
    _prefs.setString(
      key,
      jsonEncode(_items),
    );
  }

  void _load() {
    final json = jsonDecode(_prefs.getString(key) ?? '[]') as List;
    _items = json.map((e) => Item.fromJson(e)).toList();
  }
}
