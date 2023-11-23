import 'package:remnant2_calculator/domain/calculator.dart';
import 'package:remnant2_calculator/domain/effect.dart';
import 'package:test/test.dart';

void main() {
  test('Regular Damage', () {
    final calculator = Calculator();
    calculator.calculate([
      BaseDamage(100),
      AllDamage(0),
      AllCriticalChance(50),
      AllCriticalDamage(50),
      AllWeakSpotDamage(100),
    ]);
    expect(calculator.baseDamage, equals(100));
    expect(calculator.baseDamageIncrease, equals(0));
    expect(calculator.criticalChance, equals(50));
    expect(calculator.criticalDamage, equals(100));
    expect(calculator.weakSpotDamage, equals(100));

    expect(calculator.expectedDamage, equals(150));
    expect(calculator.expectedWeakSpotDamage, equals(300));
  });
}
