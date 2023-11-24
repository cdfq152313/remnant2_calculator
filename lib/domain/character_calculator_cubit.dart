import 'package:bloc/bloc.dart';
import 'package:remnant2_calculator/domain/calculation.dart';
import 'package:remnant2_calculator/domain/calculator.dart';
import 'package:remnant2_calculator/domain/character.dart';
import 'package:remnant2_calculator/domain/effect.dart';
import 'package:remnant2_calculator/extension.dart';

class CharacterCalculatorCubit extends Cubit<CharacterCalculatorCubitResult?> {
  CharacterCalculatorCubit() : super(null);
  final calculator = Calculator();

  void update(Character character) {
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
    final result = CharacterCalculatorCubitResult(
      longGun: character.longGun.to(
        (weapon) => calculator.calculate(longGunEffects, weapon.damageTypes),
      ),
      longGunMod: character.longGunMod.to(
        (weapon) => calculator.calculate(longGunEffects, weapon.damageTypes),
      ),
      handGun: character.handGun.to(
        (weapon) => calculator.calculate(handGunEffects, weapon.damageTypes),
      ),
      handGunMod: character.handGunMod.to(
        (weapon) => calculator.calculate(handGunEffects, weapon.damageTypes),
      ),
      melee: character.melee.to(
        (weapon) => calculator.calculate(meleeEffects, weapon.damageTypes),
      ),
    );
    emit(result);
  }
}

class CharacterCalculatorCubitResult {
  CharacterCalculatorCubitResult({
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
