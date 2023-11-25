import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remnant2_calculator/data/item.dart';
import 'package:remnant2_calculator/domain/character_cubit.dart';

void main() {
  group('Archetype', () {
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
  });

  group('rings', () {
    blocTest(
      'Add ring successfully',
      build: () => CharacterCubit(
        state: CharacterState(),
      ),
      act: (cubit) => cubit.setRing(0, itemMap['機率之圈']),
      expect: () => [
        CharacterState(
          rings: [itemMap['機率之圈'], null, null, null],
        ),
      ],
    );

    blocTest(
      'Remove ring',
      build: () => CharacterCubit(
        state: CharacterState(
            rings: [itemMap['機率之圈'], itemMap['扎尼亞的惡意'], null, null]),
      ),
      act: (cubit) => cubit.setRing(1, null),
      expect: () => [
        CharacterState(
          rings: [itemMap['機率之圈'], null, null, null],
        ),
      ],
    );

    blocTest(
      'Add exist ring to empty slot will remove from origin',
      build: () => CharacterCubit(
        state: CharacterState(rings: [itemMap['機率之圈'], null, null, null]),
      ),
      act: (cubit) => cubit.setRing(1, itemMap['機率之圈']),
      expect: () => [
        CharacterState(
          rings: [null, itemMap['機率之圈'], null, null],
        ),
      ],
    );

    blocTest(
      'Add exist ring to slot will switch',
      build: () => CharacterCubit(
        state: CharacterState(
          rings: [itemMap['機率之圈'], itemMap['扎尼亞的惡意'], null, null],
        ),
      ),
      act: (cubit) => cubit.setRing(1, itemMap['機率之圈']),
      expect: () => [
        CharacterState(
          rings: [itemMap['扎尼亞的惡意'], itemMap['機率之圈'], null, null],
        ),
      ],
    );
  });

  group('mutator', () {
    blocTest(
      'Add mutator',
      build: () => CharacterCubit(),
      act: (cubit) => cubit.setLongGunMutator(itemMap['動量']),
      expect: () => [
        CharacterState(
          longGunMutator: itemMap['動量'],
        ),
      ],
    );

    blocTest(
      'Add equipped mutator will remove old one',
      build: () => CharacterCubit(
        state: CharacterState(handGunMutator: itemMap['動量']),
      ),
      act: (cubit) => cubit.setLongGunMutator(itemMap['動量']),
      expect: () => [
        CharacterState(
          longGunMutator: itemMap['動量'],
        ),
      ],
    );

    blocTest(
      'Add equipped mutator will remove old one (2)',
      build: () => CharacterCubit(
        state: CharacterState(longGunMutator: itemMap['動量']),
      ),
      act: (cubit) => cubit.setHandGunMutator(itemMap['動量']),
      expect: () => [
        CharacterState(
          handGunMutator: itemMap['動量'],
        ),
      ],
    );
  });
}
