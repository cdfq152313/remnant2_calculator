import 'dart:math';

import 'package:remnant2_calculator/domain/effect.dart';
import 'package:remnant2_calculator/extension.dart';

class Calculator {
  Calculation calculate(
    List<Effect> effects,
    List<DamageType> applyDamageTypes,
  ) {
    final effectMap = mergeEffect(effects, applyDamageTypes);
    final baseDamage = effectMap[BaseDamage] ?? 100;
    final baseDamageIncrease = effectMap[DamageIncrease] ?? 0;
    final criticalChance = effectMap[CriticalChance] ?? 0;
    final criticalDamage = 50 + (effectMap[CriticalDamage] ?? 0);
    final weakSpotDamage = effectMap[WeakSpotDamage] ?? 0;

    final expectedDamage = baseDamage *
        (1 + baseDamageIncrease.pc) *
        (1 + criticalDamage.pc * criticalChance.pc);
    final expectedWeakSpotDamage = expectedDamage * (1 + weakSpotDamage.pc);
    return Calculation(
      baseDamage: baseDamage,
      baseDamageIncrease: baseDamageIncrease,
      criticalChance: criticalChance,
      criticalDamage: criticalDamage,
      weakSpotDamage: weakSpotDamage,
      expectedDamage: expectedDamage.toInt(),
      expectedWeakSpotDamage: expectedWeakSpotDamage.toInt(),
    );
  }

  Map<Type, int> mergeEffect(
    List<Effect> effects,
    List<DamageType> applyDamageTypes,
  ) {
    final applyDamageTypeSet = applyDamageTypes.toSet();
    final map = <Type, int>{};
    for (final effect in effects.where(
      (effect) => effect.damageTypes.any(
        (damageType) => applyDamageTypeSet.contains(damageType),
      ),
    )) {
      map.update(
        effect.runtimeType,
        (value) => value + effect.value,
        ifAbsent: () => effect.value,
      );
    }
    map.update(CriticalChance, (value) => min(100, value), ifAbsent: () => 0);
    return map;
  }
}

class Calculation {
  Calculation({
    required this.baseDamage,
    required this.baseDamageIncrease,
    required this.criticalChance,
    required this.criticalDamage,
    required this.weakSpotDamage,
    required this.expectedDamage,
    required this.expectedWeakSpotDamage,
  });

  final int baseDamage;

  final int baseDamageIncrease;

  final int criticalChance;

  final int criticalDamage;

  final int weakSpotDamage;

  final int expectedDamage;

  final int expectedWeakSpotDamage;
}
