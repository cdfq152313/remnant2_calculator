import 'package:remnant2_calculator/domain/calculator.dart';
import 'package:remnant2_calculator/domain/effect.dart';
import 'package:test/test.dart';

void main() {
  final calculator = Calculator();
  test('sum effect', () {
    final result = calculator.mergeEffect(
      [
        BaseDamage(100),
        BaseDamage(50),
        BaseDamage(30),
      ],
      DamageType.values,
    );
    expect(result[BaseDamage], equals(180));
  });

  test('critical chance cannot exceed 100', () {
    final result = calculator.mergeEffect(
      [
        CriticalChance(40),
        CriticalChance(30),
        CriticalChance(40),
      ],
      DamageType.values,
    );
    expect(result[CriticalChance], equals(100));
  });

  test('All Damage', () {
    final result = calculator.calculate(
      [
        BaseDamage(100),
        DamageIncrease(0),
        CriticalChance(50),
        CriticalDamage(50),
        WeakSpotDamage(100),
      ],
      DamageType.values,
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
