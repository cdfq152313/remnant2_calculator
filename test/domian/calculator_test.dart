import 'package:remnant2_calculator/domain/calculator.dart';
import 'package:remnant2_calculator/domain/effect.dart';
import 'package:test/test.dart';

void main() {
  test('All Damage', () {
    final calculator = Calculator.allDamageCalculator;
    final result = calculator.calculate(Effect.collect([
      BaseDamage(100),
      AllDamage(0),
      AllCriticalChance(50),
      AllCriticalDamage(50),
      AllWeakSpotDamage(100),
    ]));
    expect(result.baseDamage, equals(100));
    expect(result.baseDamageIncrease, equals(0));
    expect(result.criticalChance, equals(50));
    expect(result.criticalDamage, equals(100));
    expect(result.weakSpotDamage, equals(100));

    expect(result.expectedDamage, equals(150));
    expect(result.expectedWeakSpotDamage, equals(300));
  });
}
