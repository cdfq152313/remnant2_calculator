import 'package:remnant2_calculator/repository/weapon_repository.dart';

class HandGunRepository extends WeaponRepository {
  HandGunRepository(super._prefs);

  @override
  final String key = 'HandGun';
}
