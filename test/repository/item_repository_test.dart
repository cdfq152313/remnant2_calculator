import 'package:remnant2_calculator/domain/base_damage.dart';
import 'package:remnant2_calculator/domain/damage_type.dart';
import 'package:remnant2_calculator/domain/item.dart';
import 'package:remnant2_calculator/repository/archetype_repository.dart';
import 'package:remnant2_calculator/repository/melee_repository.dart';
import 'package:remnant2_calculator/repository/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';

void main() {
  test('archetype test', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    const item = Item(name: 'hello', effects: []);
    var repository = ArchetypeRepository(prefs, {});
    final event = repository.stream.first;

    repository.add(item);
    repository = ArchetypeRepository(prefs, {});

    expect(await event, isA<Update>());
    expect(repository.get(item.name).toString(), equals(item.toString()));
  });

  test('weapon test', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    const item = Weapon(
      name: 'hello',
      effects: [],
      damage: BaseDamage(100, damageTypes: [DamageType.range]),
    );
    var repository = MeleeRepository(prefs, {});
    final event = repository.stream.first;

    repository.add(item);
    repository = MeleeRepository(prefs, {});

    expect(await event, isA<Update>());
    expect(repository.get(item.name).toString(), equals(item.toString()));
  });
}
