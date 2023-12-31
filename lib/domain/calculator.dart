import 'dart:math';

import 'package:remnant2_calculator/domain/base_damage.dart';
import 'package:remnant2_calculator/domain/damage_type.dart';
import 'package:remnant2_calculator/domain/effect.dart';
import 'package:remnant2_calculator/extension.dart';

class Calculator {
  Calculation calculate(
    BaseDamage baseDamage,
    List<Effect> effects,
  ) {
    final effectMap = mergeEffect(effects, baseDamage.damageTypes);
    final baseDamageIncrease = effectMap[EffectType.damageIncrease] ?? 0;
    final criticalChance = effectMap[EffectType.criticalChance] ?? 0;
    final criticalDamage = 50 + (effectMap[EffectType.criticalDamage] ?? 0);
    final weakSpotDamage = effectMap[EffectType.weakSpotDamage] ?? 0;
    final fireRate = effectMap[EffectType.fireRate] ?? 0;

    final expectedDamage = baseDamage.value *
        (1 + baseDamageIncrease.pc) *
        (1 + criticalDamage.pc * criticalChance.pc);
    final expectedWeakSpotDamage = expectedDamage * (1 + weakSpotDamage.pc);
    final double? expectedDps = baseDamage.rps?.to(
        (rps) => rps == 0 ? null : expectedDamage * rps * (1 + fireRate.pc));
    final double? expectedWeakSpotDps = baseDamage.rps?.to((rps) =>
        rps == 0 ? null : expectedWeakSpotDamage * rps * (1 + fireRate.pc));
    return Calculation(
      baseDamageIncrease: baseDamageIncrease.toInt(),
      criticalChance: criticalChance.toInt(),
      criticalDamage: criticalDamage.toInt(),
      weakSpotDamage: weakSpotDamage.toInt(),
      fireRate: fireRate,
      expectedDamage: expectedDamage.toInt(),
      expectedWeakSpotDamage: expectedWeakSpotDamage.toInt(),
      expectedDps: expectedDps?.toInt(),
      expectedWeakSpotDps: expectedWeakSpotDps?.toInt(),
    );
  }

  Map<EffectType, double> mergeEffect(
    List<Effect> effects,
    List<DamageType> applyDamageTypes,
  ) {
    final applyDamageTypeSet = applyDamageTypes.toSet();
    final map = <EffectType, double>{};
    for (final effect in effects.where(
      (effect) => effect.damageTypes.any(
        (damageType) => applyDamageTypeSet.contains(damageType),
      ),
    )) {
      map.update(
        effect.type,
        (value) => value + effect.value,
        ifAbsent: () => effect.value,
      );
    }
    map.update(
      EffectType.criticalChance,
      (value) => min(100, value),
      ifAbsent: () => 0,
    );
    return map;
  }
}

class Calculation {
  Calculation({
    required this.baseDamageIncrease,
    required this.criticalChance,
    required this.criticalDamage,
    required this.weakSpotDamage,
    this.fireRate,
    required this.expectedDamage,
    required this.expectedWeakSpotDamage,
    this.expectedDps,
    this.expectedWeakSpotDps,
  });

  final int baseDamageIncrease;

  final int criticalChance;

  final int criticalDamage;

  final int weakSpotDamage;

  final double? fireRate;

  final int expectedDamage;

  final int expectedWeakSpotDamage;

  final int? expectedDps;

  final int? expectedWeakSpotDps;
}
