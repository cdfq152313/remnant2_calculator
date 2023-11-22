import 'package:remnant2_calculator/domain/calculator.dart';
import 'package:test/test.dart';

void main() {
  test('Base Value', () {
    final calculator = Calculator();
    const base = 100.0;
    calculator.setBase(base);
    final result = calculator.calculate();
    expect(result, equals(base));
  });

  test('Critical Chance & Critical Damage', () {
    final calculator = Calculator();
    const base = 100.0;
    calculator.setBase(base);
    calculator.setCriticalChance(50);
    calculator.setCriticalDamage(100);
    final result = calculator.calculate();
    expect(result, equals(150));
  });
}
