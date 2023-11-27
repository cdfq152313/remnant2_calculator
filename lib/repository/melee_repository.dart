import 'package:remnant2_calculator/data/item.dart';
import 'package:remnant2_calculator/domain/item.dart';
import 'package:remnant2_calculator/repository/weapon_repository.dart';

class MeleeRepository extends WeaponRepository {
  MeleeRepository(super._prefs);

  @override
  final String key = 'Melee';

  @override
  List<Weapon> getDefaultItems() => melees;
}
