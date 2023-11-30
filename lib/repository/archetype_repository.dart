import 'package:remnant2_calculator/repository/item_repository.dart';

class ArchetypeRepository extends ItemRepository {
  ArchetypeRepository(super._prefs, super.defaultJson);

  @override
  final String key = 'Archetype';
}
