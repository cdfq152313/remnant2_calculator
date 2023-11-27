import 'package:remnant2_calculator/data/item.dart';
import 'package:remnant2_calculator/domain/item.dart';
import 'package:remnant2_calculator/repository/weapon_repository.dart';

class LongGunRepository extends WeaponRepository {
  LongGunRepository(super._prefs);

  @override
  final String key = 'LongGun';

  @override
  List<Weapon> getDefaultItems() => longGuns;
}
