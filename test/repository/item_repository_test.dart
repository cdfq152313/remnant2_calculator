import 'package:remnant2_calculator/domain/item.dart';
import 'package:remnant2_calculator/repository/archetype_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';

void main() {
  test('archetype test', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final item = Item(name: 'hello', effects: []);
    var repository = ArchetypeRepository(prefs);
    repository.add(item);
    repository = ArchetypeRepository(prefs);

    expect(repository.getAll().first.toString(), equals(item.toString()));
  });
}
