import 'package:bloc/bloc.dart';
import 'package:remnant2_calculator/domain/calculator.dart';
import 'package:remnant2_calculator/domain/character_cubit.dart';
import 'package:remnant2_calculator/domain/effect.dart';
import 'package:remnant2_calculator/extension.dart';

class CalculatorCubit extends Cubit<CalculatorState> {
  CalculatorCubit() : super(CalculatorState());
  final calculator = Calculator();

  void update(CharacterState character) {
    final regularEffects = <Effect>[
      ...character.primaryArchetype?.effects ?? [],
      ...character.secondaryArchetype?.effects ?? [],
      ...character.amulet?.effects ?? [],
      for (final ring in character.rings) ...ring?.effects ?? [],
      for (final relicFragment in character.relicFragments)
        ...relicFragment?.effects ?? [],
      for (final modifier in character.regularModifiers) ...modifier.effects,
    ];
    final longGunEffects = <Effect>[
      ...character.longGun?.effects ?? [],
      ...character.longGunMutator?.effects ?? [],
      for (final modifier in character.longGunModifiers) ...modifier.effects,
      ...regularEffects,
    ];
    final handGunEffects = <Effect>[
      ...character.handGun?.effects ?? [],
      ...character.handGunMutator?.effects ?? [],
      for (final modifier in character.handGunModifiers) ...modifier.effects,
      ...regularEffects,
    ];
    final meleeEffects = <Effect>[
      ...character.melee?.effects ?? [],
      ...character.meleeMutator?.effects ?? [],
      for (final modifier in character.meleeModifiers) ...modifier.effects,
      ...regularEffects,
    ];
    final result = CalculatorState(
      longGun: character.longGun.to(
        (weapon) => calculator.calculate(weapon.damage, longGunEffects),
      ),
      longGunMod: character.longGunMod.to(
        (weapon) => calculator.calculate(weapon.damage, longGunEffects),
      ),
      handGun: character.handGun.to(
        (weapon) => calculator.calculate(weapon.damage, handGunEffects),
      ),
      handGunMod: character.handGunMod.to(
        (weapon) => calculator.calculate(weapon.damage, handGunEffects),
      ),
      melee: character.melee.to(
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
