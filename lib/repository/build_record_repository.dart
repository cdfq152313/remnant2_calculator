import 'package:remnant2_calculator/domain/build_record_cubit.dart';
import 'package:remnant2_calculator/repository/repository.dart';

class BuildRecordRepository extends Repository<BuildRecordState> {
  BuildRecordRepository(super._prefs) {
    _load();
  }

  @override
  final String key = 'Build';

  @override
  BuildRecordState fromJson(Map<String, dynamic> json) =>
      BuildRecordState.fromJson(json);

  List<BuildRecordState> _items = [];

  @override
  List<BuildRecordState> export() {
    return getAll();
  }

  @override
  void onImport(List<BuildRecordState> data) {
    final exist = _items.toSet();
    for (final item in data) {
      if (!exist.contains(item)) {
        _items.add(item);
      }
    }
    saveToDb(_items);
  }

  List<BuildRecordState> getAll() {
    return _items.toList();
  }

  void replace(int index, BuildRecordState state) {
    _items[index] = state;
    saveToDb(_items);
  }

  void add(BuildRecordState state) {
    _items.add(state);
    saveToDb(_items);
  }

  void removeAt(int index) {
    _items.removeAt(index);
    saveToDb(_items);
  }

  void _load() {
    _items = loadFromDb();
  }
}
