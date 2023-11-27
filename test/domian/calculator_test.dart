import 'package:remnant2_calculator/domain/base_damage.dart';
import 'package:remnant2_calculator/domain/calculator.dart';
import 'package:remnant2_calculator/domain/effect.dart';
import 'package:test/test.dart';

void main() {
  final calculator = Calculator();
  test('sum effect', () {
    final result = calculator.mergeEffect(
      [
        const CriticalDamage(100),
        const CriticalDamage(50),
        const CriticalDamage(30),
      ],
      DamageType.values,
    );
    expect(result[CriticalDamage], equals(180));
  });

  test('critical chance cannot exceed 100', () {
    final result = calculator.mergeEffect(
      [
        const CriticalChance(40),
        const CriticalChance(30),
        const CriticalChance(40),
      ],
      DamageType.values,
    );
    expect(result[CriticalChance], equals(100));
  });

  test('All Damage', () {
    final result = calculator.calculate(
      const BaseDamage(100, DamageType.values),
      [
        const DamageIncrease(0),
        const CriticalChance(50),
        const CriticalDamage(50),
        const WeakSpotDamage(100),
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
