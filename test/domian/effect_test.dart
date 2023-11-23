import 'package:remnant2_calculator/domain/effect.dart';
import 'package:test/test.dart';

void main() {
  test('sum effect', () {
    final result = Effect.collect(
      [
        BaseDamage(100),
        BaseDamage(50),
        BaseDamage(30),
      ],
    );
    expect(result[BaseDamage]!.value, equals(180));
  });

  test('critical chance cannot exceed 100', () {
    final result = Effect.collect([
      AllCriticalChance(40),
      AllCriticalChance(30),
      AllCriticalChance(40),
    ]);
    expect(result[AllCriticalChance]!.value, equals(100));
  });
}
