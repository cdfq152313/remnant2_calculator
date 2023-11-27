import 'package:remnant2_calculator/data/item.dart';
import 'package:remnant2_calculator/domain/item.dart';
import 'package:remnant2_calculator/repository/item_repository.dart';

class ArchetypeRepository extends ItemRepository {
  ArchetypeRepository(super._prefs);

  @override
  final String key = 'Archetype';

  @override
  List<Item> getDefaultItems() => archetypes;
}
