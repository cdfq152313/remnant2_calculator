import 'package:remnant2_calculator/domain/effect.dart';

class BaseDamage {
  BaseDamage(this.value, this.damageTypes);

  final int value;
  final List<DamageType> damageTypes;
}
