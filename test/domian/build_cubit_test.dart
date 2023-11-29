import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remnant2_calculator/data/item.dart';
import 'package:remnant2_calculator/domain/build_cubit.dart';

void main() {
  group('Archetype', () {
    blocTest(
      'Set Primary Archetype successfully',
      build: () => BuildCubit(),
      act: (cubit) => cubit.setPrimaryArchetype(itemMap['獵人']),
      expect: () => [
        BuildState(primaryArchetype: itemMap['獵人']),
      ],
    );

    blocTest(
      'Set Primary Archetype not effect Secondary Archetype',
      build: () => BuildCubit(
        state: BuildState(secondaryArchetype: itemMap['槍手']),
      ),
      act: (cubit) => cubit.setPrimaryArchetype(itemMap['獵人']),
      expect: () => [
        BuildState(
          primaryArchetype: itemMap['獵人'],
          secondaryArchetype: itemMap['槍手'],
        ),
      ],
    );

    blocTest(
      'Set Primary Archetype to null not effect Secondary Archetype',
      build: () => BuildCubit(
        state: BuildState(primaryArchetype: itemMap['槍手']),
      ),
      act: (cubit) => cubit.setPrimaryArchetype(null),
      expect: () => [
        BuildState(),
      ],
    );

    blocTest(
      'Switch Primary Archetype to Secondary Archetype when select same item',
      build: () => BuildCubit(
        state: BuildState(
          primaryArchetype: itemMap['獵人'],
          secondaryArchetype: itemMap['槍手'],
        ),
      ),
      act: (cubit) => cubit.setPrimaryArchetype(itemMap['槍手']),
      expect: () => [
        BuildState(
          primaryArchetype: itemMap['槍手'],
          secondaryArchetype: itemMap['獵人'],
        ),
      ],
    );

    blocTest(
      'Set Secondary Archetype successfully',
      build: () => BuildCubit(),
      act: (cubit) => cubit.setSecondaryArchetype(itemMap['槍手']),
      expect: () => [
        BuildState(secondaryArchetype: itemMap['槍手']),
      ],
    );

    blocTest(
      'Set Secondary Archetype not effect Primary Archetype',
      build: () => BuildCubit(
        state: BuildState(primaryArchetype: itemMap['獵人']),
      ),
      act: (cubit) => cubit.setSecondaryArchetype(itemMap['槍手']),
      expect: () => [
        BuildState(
          primaryArchetype: itemMap['獵人'],
          secondaryArchetype: itemMap['槍手'],
        ),
      ],
    );

    blocTest(
      'Set Secondary Archetype to null not effect Primary Archetype',
      build: () => BuildCubit(
        state: BuildState(secondaryArchetype: itemMap['槍手']),
      ),
      act: (cubit) => cubit.setSecondaryArchetype(null),
      expect: () => [
        BuildState(),
      ],
    );

    blocTest(
      'Switch Secondary Archetype to Primary Archetype when select same item',
      build: () => BuildCubit(
        state: BuildState(
          primaryArchetype: itemMap['獵人'],
          secondaryArchetype: itemMap['槍手'],
        ),
      ),
      act: (cubit) => cubit.setSecondaryArchetype(itemMap['獵人']),
      expect: () => [
        BuildState(
          primaryArchetype: itemMap['槍手'],
          secondaryArchetype: itemMap['獵人'],
        ),
      ],
    );
  });

  group('rings', () {
    blocTest(
      'Add ring successfully',
      build: () => BuildCubit(
        state: BuildState(),
      ),
      act: (cubit) => cubit.setRing(0, itemMap['機率之圈']),
      expect: () => [
        BuildState(
          rings: [itemMap['機率之圈'], null, null, null],
        ),
      ],
    );

    blocTest(
      'Remove ring',
      build: () => BuildCubit(
        state:
            BuildState(rings: [itemMap['機率之圈'], itemMap['扎尼亞的惡意'], null, null]),
      ),
      act: (cubit) => cubit.setRing(1, null),
      expect: () => [
        BuildState(
          rings: [itemMap['機率之圈'], null, null, null],
        ),
      ],
    );

    blocTest(
      'Add exist ring to empty slot will remove from origin',
      build: () => BuildCubit(
        state: BuildState(rings: [itemMap['機率之圈'], null, null, null]),
      ),
      act: (cubit) => cubit.setRing(1, itemMap['機率之圈']),
      expect: () => [
        BuildState(
          rings: [null, itemMap['機率之圈'], null, null],
        ),
      ],
    );

    blocTest(
      'Add exist ring to slot will switch',
      build: () => BuildCubit(
        state: BuildState(
          rings: [itemMap['機率之圈'], itemMap['扎尼亞的惡意'], null, null],
        ),
      ),
      act: (cubit) => cubit.setRing(1, itemMap['機率之圈']),
      expect: () => [
        BuildState(
          rings: [itemMap['扎尼亞的惡意'], itemMap['機率之圈'], null, null],
        ),
      ],
    );
  });

  group('mutator', () {
    blocTest(
      'Add mutator',
      build: () => BuildCubit(),
      act: (cubit) => cubit.setLongGunMutator(itemMap['動量']),
      expect: () => [
        BuildState(
          longGunMutator: itemMap['動量'],
        ),
      ],
    );

    blocTest(
      'Add equipped mutator will remove old one',
      build: () => BuildCubit(
        state: BuildState(handGunMutator: itemMap['動量']),
      ),
      act: (cubit) => cubit.setLongGunMutator(itemMap['動量']),
      expect: () => [
        BuildState(
          longGunMutator: itemMap['動量'],
        ),
      ],
    );

    blocTest(
      'Add equipped mutator will remove old one (2)',
      build: () => BuildCubit(
        state: BuildState(longGunMutator: itemMap['動量']),
      ),
      act: (cubit) => cubit.setHandGunMutator(itemMap['動量']),
      expect: () => [
        BuildState(
          handGunMutator: itemMap['動量'],
        ),
      ],
    );
  });
}
