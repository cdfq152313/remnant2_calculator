import 'package:remnant2_calculator/domain/item.dart';
import 'package:remnant2_calculator/repository/item_repository.dart';

class LongGunRepository extends ItemRepository<Weapon> {
  LongGunRepository(super._prefs, super.defaultJson);

  @override
  final String key = 'LongGun';
}
