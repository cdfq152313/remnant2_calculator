import 'package:bloc_test/bloc_test.dart';
import 'package:remnant2_calculator/data/item.dart';
import 'package:remnant2_calculator/domain/character_cubit.dart';

void main() {
  blocTest(
    'Set Primary Archetype successfully',
    build: () => CharacterCubit(),
    act: (cubit) => cubit.setPrimaryArchetype(itemMap['獵人']),
    expect: () => [
      CharacterState(primaryArchetype: itemMap['獵人']),
    ],
  );

  blocTest(
    'Set Primary Archetype not effect Secondary Archetype',
    build: () => CharacterCubit(
      state: CharacterState(secondaryArchetype: itemMap['槍手']),
    ),
    act: (cubit) => cubit.setPrimaryArchetype(itemMap['獵人']),
    expect: () => [
      CharacterState(
        primaryArchetype: itemMap['獵人'],
        secondaryArchetype: itemMap['槍手'],
      ),
    ],
  );

  blocTest(
    'Set Primary Archetype to null not effect Secondary Archetype',
    build: () => CharacterCubit(
      state: CharacterState(primaryArchetype: itemMap['槍手']),
    ),
    act: (cubit) => cubit.setPrimaryArchetype(null),
    expect: () => [
      CharacterState(),
    ],
  );

  blocTest(
    'Switch Primary Archetype to Secondary Archetype when select same item',
    build: () => CharacterCubit(
      state: CharacterState(
        primaryArchetype: itemMap['獵人'],
        secondaryArchetype: itemMap['槍手'],
      ),
    ),
    act: (cubit) => cubit.setPrimaryArchetype(itemMap['槍手']),
    expect: () => [
      CharacterState(
        primaryArchetype: itemMap['槍手'],
        secondaryArchetype: itemMap['獵人'],
      ),
    ],
  );

  blocTest(
    'Set Secondary Archetype successfully',
    build: () => CharacterCubit(),
    act: (cubit) => cubit.setSecondaryArchetype(itemMap['槍手']),
    expect: () => [
      CharacterState(secondaryArchetype: itemMap['槍手']),
    ],
  );

  blocTest(
    'Set Secondary Archetype not effect Primary Archetype',
    build: () => CharacterCubit(
      state: CharacterState(primaryArchetype: itemMap['獵人']),
    ),
    act: (cubit) => cubit.setSecondaryArchetype(itemMap['槍手']),
    expect: () => [
      CharacterState(
        primaryArchetype: itemMap['獵人'],
        secondaryArchetype: itemMap['槍手'],
      ),
    ],
  );

  blocTest(
    'Set Secondary Archetype to null not effect Primary Archetype',
    build: () => CharacterCubit(
      state: CharacterState(secondaryArchetype: itemMap['槍手']),
    ),
    act: (cubit) => cubit.setSecondaryArchetype(null),
    expect: () => [
      CharacterState(),
    ],
  );

  blocTest(
    'Switch Secondary Archetype to Primary Archetype when select same item',
    build: () => CharacterCubit(
      state: CharacterState(
        primaryArchetype: itemMap['獵人'],
        secondaryArchetype: itemMap['槍手'],
      ),
    ),
    act: (cubit) => cubit.setSecondaryArchetype(itemMap['獵人']),
    expect: () => [
      CharacterState(
        primaryArchetype: itemMap['槍手'],
        secondaryArchetype: itemMap['獵人'],
      ),
    ],
  );
}
