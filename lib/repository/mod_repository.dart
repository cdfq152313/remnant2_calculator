import 'package:remnant2_calculator/data/item.dart';
import 'package:remnant2_calculator/domain/item.dart';
import 'package:remnant2_calculator/repository/item_repository.dart';

class ModRepository extends ItemRepository<Weapon> {
  ModRepository(super._prefs);

  @override
  final String key = 'Mod';

  @override
  List<Weapon> getDefaultItems() => mods;
}
