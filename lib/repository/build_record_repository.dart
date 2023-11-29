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

  List<BuildRecordState> getAll() {
    return _items.toList();
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
