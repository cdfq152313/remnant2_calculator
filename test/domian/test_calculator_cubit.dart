import 'package:bloc_test/bloc_test.dart';
import 'package:remnant2_calculator/data/item.dart';
import 'package:remnant2_calculator/domain/calculator_cubit.dart';
import 'package:remnant2_calculator/domain/build_cubit.dart';
import 'package:remnant2_calculator/domain/item.dart';
import 'package:test/test.dart';

void main() {
  late CalculatorCubit cubit;
  setUp(() => cubit = CalculatorCubit());

  blocTest(
    'default long gun calculation',
    build: () => cubit,
    act: (cubit) => cubit.update(BuildState(
      primaryArchetype: itemMap['獵人'],
      secondaryArchetype: itemMap['槍手'],
      longGun: itemMap['日暮'] as Weapon,
      longGunMutator: itemMap['動量'],
      amulet: itemMap['腐蝕磨石'],
      rings: [
        itemMap['扎尼亞的惡意'],
        itemMap['機率之圈'],
      ],
      relicFragments: [
        itemMap['遠程傷害'],
        itemMap['遠程暴擊率'],
        itemMap['遠程暴擊傷害'],
      ],
      regularModifiers: [
        itemMap['獵人1技能']!,
      ],
    )),
    verify: (cubit) {
      expect(cubit.state.longGun?.expectedDamage, equals(417));
      expect(cubit.state.longGunMod, isNull);
      expect(cubit.state.handGun, isNull);
      expect(cubit.state.handGunMod, isNull);
      expect(cubit.state.melee, isNull);
    },
  );
}
