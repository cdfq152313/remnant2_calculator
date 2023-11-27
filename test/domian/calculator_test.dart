import 'package:remnant2_calculator/domain/base_damage.dart';
import 'package:remnant2_calculator/domain/calculator.dart';
import 'package:remnant2_calculator/domain/damage_type.dart';
import 'package:remnant2_calculator/domain/effect.dart';
import 'package:test/test.dart';

void main() {
  final calculator = Calculator();
  test('sum effect', () {
    final result = calculator.mergeEffect(
      [
        Effect(type: EffectType.criticalDamage, value: 100),
        Effect(type: EffectType.criticalDamage, value: 50),
        Effect(type: EffectType.criticalDamage, value: 30),
      ],
      DamageType.values,
    );
    expect(result[EffectType.criticalDamage], equals(180));
  });

  test('critical chance cannot exceed 100', () {
    final result = calculator.mergeEffect(
      [
        Effect(type: EffectType.criticalChance, value: 40),
        Effect(type: EffectType.criticalChance, value: 30),
        Effect(type: EffectType.criticalChance, value: 40),
      ],
      DamageType.values,
    );
    expect(result[EffectType.criticalChance], equals(100));
  });

  test('All Damage', () {
    final result = calculator.calculate(
      BaseDamage(100, DamageType.values),
      [
        Effect(type: EffectType.damageIncrease, value: 0),
        Effect(type: EffectType.criticalChance, value: 50),
        Effect(type: EffectType.criticalDamage, value: 50),
        Effect(type: EffectType.weakSpotDamage, value: 100),
      ],
    );
    expect(result.baseDamage, equals(100));
    expect(result.baseDamageIncrease, equals(0));
    expect(result.criticalChance, equals(50));
    expect(result.criticalDamage, equals(100));
    expect(result.weakSpotDamage, equals(100));

    expect(result.expectedDamage, equals(150));
    expect(result.expectedWeakSpotDamage, equals(300));
  });
}
