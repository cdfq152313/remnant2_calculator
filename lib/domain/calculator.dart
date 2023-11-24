import 'package:flutter/material.dart';
import 'package:remnant2_calculator/domain/calculation.dart';
import 'package:remnant2_calculator/domain/effect.dart';
import 'package:remnant2_calculator/domain/effect_merger.dart';
import 'package:remnant2_calculator/extension.dart';

abstract class Calculator {
  static Calculator allDamageCalculator = AllDamageCalculator();
  static Calculator rangeDamageCalculator = RangeDamageCalculator();

  Calculation calculate(Map<Type, Effect> effectMap) {
    final baseDamage = getBaseDamage(effectMap);
    final baseDamageIncrease = getBaseDamageIncrease(effectMap);
    final criticalChance = getCriticalChance(effectMap);
    final criticalDamage = getCriticalDamage(effectMap);
    final weakSpotDamage = getWeakSpotDamage(effectMap);

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

  @protected
  int getBaseDamage(Map<Type, Effect> effectMap) {
    return effectMap[BaseDamage]?.value ?? 100;
  }

  @protected
  int getBaseDamageIncrease(Map<Type, Effect> effectMap);

  @protected
  int getCriticalChance(Map<Type, Effect> effectMap);

  @protected
  int getCriticalDamage(Map<Type, Effect> effectMap);

  @protected
  int getWeakSpotDamage(Map<Type, Effect> effectMap);
}

class AllDamageCalculator extends Calculator {
  @override
  int getBaseDamageIncrease(Map<Type, Effect> effectMap) {
    return effectMap[AllDamage]?.value ?? 0;
  }

  @override
  int getCriticalChance(Map<Type, Effect> effectMap) {
    return effectMap[AllCriticalChance]?.value ?? 0;
  }

  @override
  int getCriticalDamage(Map<Type, Effect> effectMap) {
    return 50 + (effectMap[AllCriticalDamage]?.value ?? 0);
  }

  @override
  int getWeakSpotDamage(Map<Type, Effect> effectMap) {
    return effectMap[AllWeakSpotDamage]?.value ?? 0;
  }
}

class RangeDamageCalculator extends Calculator {
  @override
  int getBaseDamageIncrease(Map<Type, Effect> effectMap) {
    return EffectMerger.sum
        .merge(effectMap[AllDamage], effectMap[RangeDamage])
        .value;
  }

  @override
  int getCriticalChance(Map<Type, Effect> effectMap) {
    return EffectMerger.sumLimit100
        .merge(effectMap[AllCriticalChance], effectMap[RangeCriticalChance])
        .value;
  }

  @override
  int getCriticalDamage(Map<Type, Effect> effectMap) {
    return 50 +
        EffectMerger.sum
            .merge(effectMap[AllCriticalDamage], effectMap[RangeCriticalDamage])
            .value;
  }

  @override
  int getWeakSpotDamage(Map<Type, Effect> effectMap) {
    return EffectMerger.sum
        .merge(effectMap[AllWeakSpotDamage], effectMap[RangeWeakSpotDamage])
        .value;
  }
}
