import 'package:bloc/bloc.dart';
import 'package:remnant2_calculator/domain/calculation.dart';
import 'package:remnant2_calculator/domain/calculator.dart';
import 'package:remnant2_calculator/domain/character.dart';
import 'package:remnant2_calculator/domain/effect.dart';

class CharacterCalculatorCubit extends Cubit<CharacterCalculatorCubitResult?> {
  CharacterCalculatorCubit() : super(null);

  void update(Character character) {
    final regularEffects = [
      ...character.primaryArchetype?.effects ?? [],
      ...character.secondaryArchetype?.effects ?? [],
      ...character.amulet?.effects ?? [],
      for (final ring in character.rings) ...ring?.effects ?? [],
      for (final relicFragment in character.relicFragments)
        ...relicFragment?.effects ?? [],
      for (final modifier in character.regularModifiers) ...modifier.effects,
    ];
    final longGunEffects = Effect.collect([
      ...character.longGun?.effects ?? [],
      ...character.longGunMutator?.effects ?? [],
      for (final modifier in character.longGunModifiers) ...modifier.effects,
      ...regularEffects,
    ]);
    final handGunEffects = Effect.collect([
      ...character.handGun?.effects ?? [],
      ...character.handGunMutator?.effects ?? [],
      for (final modifier in character.handGunModifiers) ...modifier.effects,
      ...regularEffects,
    ]);
    final meleeEffects = Effect.collect([
      ...character.melee?.effects ?? [],
      ...character.meleeMutator?.effects ?? [],
      for (final modifier in character.meleeModifiers) ...modifier.effects,
      ...regularEffects,
    ]);
    final result = CharacterCalculatorCubitResult(
      longGun: Calculator.allDamageCalculator.calculate(longGunEffects),
      longGunMod: Calculator.allDamageCalculator.calculate(longGunEffects),
      handGun: Calculator.allDamageCalculator.calculate(handGunEffects),
      handGunMod: Calculator.allDamageCalculator.calculate(handGunEffects),
      melee: Calculator.allDamageCalculator.calculate(meleeEffects),
    );
    emit(result);
  }
}

class CharacterCalculatorCubitResult {
  CharacterCalculatorCubitResult({
    required this.longGun,
    required this.longGunMod,
    required this.handGun,
    required this.handGunMod,
    required this.melee,
  });

  final Calculation longGun;
  final Calculation longGunMod;
  final Calculation handGun;
  final Calculation handGunMod;
  final Calculation melee;
}
