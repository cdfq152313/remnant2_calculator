import 'package:bloc/bloc.dart';
import 'package:remnant2_calculator/domain/calculation.dart';
import 'package:remnant2_calculator/domain/calculator.dart';
import 'package:remnant2_calculator/domain/character.dart';
import 'package:remnant2_calculator/domain/effect.dart';

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
      longGun: calculator.calculate(longGunEffects, [DamageType.range]),
      longGunMod: calculator.calculate(longGunEffects, [DamageType.mod]),
      handGun: calculator.calculate(handGunEffects, [DamageType.range]),
      handGunMod: calculator.calculate(handGunEffects, [DamageType.mod]),
      melee: calculator.calculate(meleeEffects, [DamageType.melee]),
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
