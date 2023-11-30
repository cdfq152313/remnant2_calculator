import 'package:remnant2_calculator/domain/item.dart';
import 'package:remnant2_calculator/repository/item_repository.dart';

class MeleeRepository extends ItemRepository<Weapon> {
  MeleeRepository(super._prefs, super.defaultJson);

  @override
  final String key = 'Melee';
}
