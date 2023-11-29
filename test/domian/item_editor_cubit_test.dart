import 'package:bloc_test/bloc_test.dart';
import 'package:remnant2_calculator/domain/damage_type.dart';
import 'package:remnant2_calculator/domain/effect.dart';
import 'package:remnant2_calculator/domain/item.dart';
import 'package:remnant2_calculator/domain/item_editor_cubit.dart';
import 'package:remnant2_calculator/repository/archetype_repository.dart';
import 'package:remnant2_calculator/repository/item_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';

void main() async {
  group('Regular item', () {
    late ItemRepository repository;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      repository = ArchetypeRepository(prefs);
    });

    blocTest(
      'Test setName',
      build: () => RegularItemEditorCubit(repository),
      act: (cubit) => cubit.setName('hello'),
      expect: () => [
        const ItemEditorState(Item(name: 'hello')),
      ],
    );

    blocTest(
      'Test addEffect',
      build: () => RegularItemEditorCubit(repository),
      act: (cubit) => cubit.addEffect(),
      expect: () => [
        ItemEditorState(
          Item(name: '', effects: [
            Effect.damageIncrease(0),
          ]),
        ),
      ],
    );

    blocTest(
      'Test removeEffect',
      build: () => RegularItemEditorCubit(repository),
      act: (cubit) {
        cubit.addEffect();
        cubit.removeEffectAt(0);
      },
      skip: 1,
      expect: () => [
        const ItemEditorState(Item(name: '', effects: [])),
      ],
    );

    blocTest(
      'Test editEffectValue',
      build: () => RegularItemEditorCubit(repository),
      act: (cubit) {
        cubit.addEffect();
        cubit.editEffectValue(0, '100');
      },
      skip: 1,
      expect: () => [
        ItemEditorState(Item(name: '', effects: [
          Effect.damageIncrease(100),
        ])),
      ],
    );

    blocTest(
      'Test editEffectType',
      build: () => RegularItemEditorCubit(repository),
      act: (cubit) {
        cubit.addEffect();
        cubit.editEffectValue(0, '33');
        cubit.editEffectType(0, EffectType.weakSpotDamage);
      },
      skip: 2,
      expect: () => [
        ItemEditorState(Item(
          name: '',
          effects: [
            Effect.weakSpotDamage(33),
          ],
        )),
      ],
    );

    blocTest(
      'Test editEffectDamageType',
      build: () => RegularItemEditorCubit(repository),
      act: (cubit) {
        cubit.addEffect();
        cubit.editEffectDamageType(0, DamageType.range, false);
      },
      skip: 1,
      expect: () => [
        ItemEditorState(Item(
          name: '',
          effects: [
            Effect.damageIncrease(0, damageTypes: [
              DamageType.melee,
              DamageType.mod,
              DamageType.elemental,
              DamageType.status
            ]),
          ],
        )),
      ],
    );

    blocTest(
      'Item save successfully',
      build: () => RegularItemEditorCubit(repository),
      act: (cubit) {
        cubit.setName('hello');
        cubit.save();
      },
      skip: 1,
      expect: () => [
        const ItemEditorState<Item>(
          Item(name: 'hello'),
          finish: true,
        ),
      ],
    );

    blocTest(
      'Item name cannot be empty',
      build: () => RegularItemEditorCubit(repository),
      act: (cubit) {
        cubit.setName('   ');
        cubit.save();
      },
      skip: 1,
      expect: () => [
        const ItemEditorState<Item>(
          Item(name: '   '),
          nameError: true,
        ),
      ],
    );
  });
}
