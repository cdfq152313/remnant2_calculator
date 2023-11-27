import 'package:remnant2_calculator/data/item.dart';
import 'package:remnant2_calculator/domain/item.dart';
import 'package:remnant2_calculator/repository/weapon_repository.dart';

class HandGunRepository extends WeaponRepository {
  HandGunRepository(super._prefs);

  @override
  final String key = 'HandGun';

  @override
  List<Weapon> getDefaultItems() => handGuns;
}
