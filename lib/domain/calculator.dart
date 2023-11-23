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

  void calculate(Map<Type, Effect> effectMap) {
    baseDamage = effectMap[BaseDamage]?.value ?? 100;
    baseDamageIncrease = effectMap[AllDamage]?.value ?? 0;
    criticalChance = effectMap[AllCriticalChance]?.value ?? 0;
    criticalDamage = 50 + (effectMap[AllCriticalDamage]?.value ?? 0);
    weakSpotDamage = effectMap[AllWeakSpotDamage]?.value ?? 0;

    expectedDamage = (baseDamage *
            (1 + baseDamageIncrease.pc) *
            (1 + criticalDamage.pc * criticalChance.pc))
        .toInt();
    expectedWeakSpotDamage = (expectedDamage * (1 + weakSpotDamage.pc)).toInt();
  }
}
