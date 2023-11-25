import 'package:bloc_test/bloc_test.dart';
import 'package:remnant2_calculator/data/item.dart';
import 'package:remnant2_calculator/domain/character_cubit.dart';

void main() {
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
