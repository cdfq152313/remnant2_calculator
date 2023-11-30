import 'package:remnant2_calculator/domain/item.dart';
import 'package:remnant2_calculator/repository/item_repository.dart';

class HandGunRepository extends ItemRepository<Weapon> {
  HandGunRepository(super._prefs, super.defaultJson);

  @override
  final String key = 'HandGun';
}
