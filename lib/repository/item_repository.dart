import 'package:remnant2_calculator/domain/item.dart';
import 'package:remnant2_calculator/repository/repository.dart';

abstract class ItemRepository<T extends Item> extends Repository<T> {
  ItemRepository(super._prefs) {
    _load();
  }

  List<T> _items = [];
  List<T> _customizedItems = [];

  @override
  T fromJson(Map<String, dynamic> json) => Item.fromJson(json) as T;

  T get(String key) {
    return _items.firstWhere((element) => element.name == key);
  }

  List<T> getAll() {
    return _items.toList();
  }

  List<T> getAllCustomized() {
    return _customizedItems.toList();
  }

  List<T> filterCustomized(String keyword) {
    return _customizedItems
        .where((element) => element.name.contains(keyword))
        .toList();
  }

  List<T> filter(String keyword) {
    return _items.where((element) => element.name.contains(keyword)).toList();
  }

  void add(T item) {
    _items.add(item);
    _customizedItems.add(item);
    saveToDb(_customizedItems);
  }

  void remove(T item) {
    _items.remove(item);
    _customizedItems.remove(item);
    saveToDb(_customizedItems);
  }

  List<T> getDefaultItems() => [];

  void _load() {
    _customizedItems = loadFromDb();
    _items = [
      ...getDefaultItems(),
      ..._customizedItems,
    ];
  }
}
