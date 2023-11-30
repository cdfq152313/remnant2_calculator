import 'package:bloc/bloc.dart';
import 'package:remnant2_calculator/domain/build_cubit.dart';
import 'package:remnant2_calculator/domain/calculator.dart';
import 'package:remnant2_calculator/domain/effect.dart';
import 'package:remnant2_calculator/extension.dart';

class CalculatorCubit extends Cubit<CalculatorState> {
  CalculatorCubit() : super(CalculatorState());
  final calculator = Calculator();

  void update(BuildState build) {
    final regularEffects = <Effect>[
      ...build.primaryArchetype?.effects ?? [],
      ...build.secondaryArchetype?.effects ?? [],
      ...build.primarySkill?.effects ?? [],
      ...build.secondarySkill?.effects ?? [],
      ...build.amulet?.effects ?? [],
      for (final ring in build.rings) ...ring?.effects ?? [],
      for (final relicFragment in build.relicFragments)
        ...relicFragment?.effects ?? [],
      for (final modifier in build.regularModifiers) ...modifier.effects,
    ];
    final longGunEffects = <Effect>[
      ...build.longGun?.effects ?? [],
      ...build.longGunMutator?.effects ?? [],
      ...build.longGunModifier?.effects ?? [],
      ...regularEffects,
    ];
    final handGunEffects = <Effect>[
      ...build.handGun?.effects ?? [],
      ...build.handGunMutator?.effects ?? [],
      ...build.handGunModifier?.effects ?? [],
      ...regularEffects,
    ];
    final meleeEffects = <Effect>[
      ...build.melee?.effects ?? [],
      ...build.meleeMutator?.effects ?? [],
      ...regularEffects,
    ];
    final result = CalculatorState(
      longGun: build.longGun.to(
        (weapon) => calculator.calculate(weapon.damage, longGunEffects),
      ),
      longGunMod: build.longGunMod.to(
        (weapon) => calculator.calculate(weapon.damage, longGunEffects),
      ),
      handGun: build.handGun.to(
        (weapon) => calculator.calculate(weapon.damage, handGunEffects),
      ),
      handGunMod: build.handGunMod.to(
        (weapon) => calculator.calculate(weapon.damage, handGunEffects),
      ),
      melee: build.melee.to(
        (weapon) => calculator.calculate(weapon.damage, meleeEffects),
      ),
    );
    emit(result);
  }
}

class CalculatorState {
  CalculatorState({
    this.longGun,
    this.longGunMod,
    this.handGun,
    this.handGunMod,
    this.melee,
  });

  final Calculation? longGun;
  final Calculation? longGunMod;
  final Calculation? handGun;
  final Calculation? handGunMod;
  final Calculation? melee;
}
