import 'package:remnant2_calculator/domain/character_cubit.dart';
import 'package:remnant2_calculator/repository/repository.dart';

class CharacterRepository extends Repository<CharacterState> {
  CharacterRepository(super._prefs) {
    _load();
  }

  @override
  final String key = 'Character';

  @override
  CharacterState fromJson(Map<String, dynamic> json) =>
      CharacterState.fromJson(json);

  List<CharacterState> _items = [];

  List<CharacterState> getAll() {
    return _items.toList();
  }

  void add(CharacterState state) {
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
