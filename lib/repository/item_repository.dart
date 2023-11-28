import 'dart:async';
import 'dart:convert';

import 'package:remnant2_calculator/domain/item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemUpdate {}

abstract class ItemRepository<T extends Item> {
  ItemRepository(this._prefs) {
    _load();
  }

  final SharedPreferences _prefs;
  final StreamController<ItemUpdate> _controller = StreamController.broadcast();

  String get key;

  List<T> _items = [];
  List<T> _customizeditems = [];

  Stream<ItemUpdate> get stream => _controller.stream;

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
    _customizeditems.add(item);
    _save();
  }

  void remove(T item) {
    _items.remove(item);
    _customizeditems.remove(item);
    _save();
  }

  List<T> getDefaultItems() => [];

  void _save() {
    _controller.sink.add(ItemUpdate());
    _prefs.setString(
      key,
      jsonEncode(_customizeditems),
    );
  }

  void _load() {
    _items = getDefaultItems();
    final json = jsonDecode(_prefs.getString(key) ?? '[]') as List;
    _customizeditems = json.map((v) => Item.fromJson(v) as T).toList();
    _items.addAll(_customizeditems);
  }
}
