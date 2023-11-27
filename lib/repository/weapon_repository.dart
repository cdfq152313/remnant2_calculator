import 'package:remnant2_calculator/domain/item.dart';
import 'package:remnant2_calculator/repository/item_repository.dart';

abstract class WeaponRepository extends ItemRepository<Weapon> {
  WeaponRepository(super.prefs);

  @override
  Weapon fromJson(Map<String, dynamic> json) {
    return Weapon.fromJson(json);
  }
}
