import 'package:remnant2_calculator/domain/effect.dart';
import 'package:remnant2_calculator/extension.dart';

class Calculator {
  int baseDamage = 0;
  int baseDamageIncrease = 0;
  int criticalChance = 0;
  int criticalDamage = 0;
  int weakSpotDamage = 0;

  int expectedDamage = 0;
  int expectedWeakSpotDamage = 0;

  void calculate(List<Effect> effects) {
    final map = <Type, Effect>{};
    for (final effect in effects) {
      if (map.containsKey(effect.runtimeType)) {
        map[effect.runtimeType] = map[effect.runtimeType]!.merge(effect);
      } else {
        map[effect.runtimeType] = effect;
      }
    }

    baseDamage = map[BaseDamage]?.value ?? 100;
    baseDamageIncrease = map[AllDamage]?.value ?? 0;
    criticalChance = map[AllCriticalChance]?.value ?? 0;
    criticalDamage = 50 + (map[AllCriticalDamage]?.value ?? 0);
    weakSpotDamage = map[AllWeakSpotDamage]?.value ?? 0;

    expectedDamage = (baseDamage *
            (1 + baseDamageIncrease.pc) *
            (1 + criticalDamage.pc * criticalChance.pc))
        .toInt();
    expectedWeakSpotDamage = (expectedDamage * (1 + weakSpotDamage.pc)).toInt();
  }
}
