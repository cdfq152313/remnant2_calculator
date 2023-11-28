import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remnant2_calculator/domain/calculator.dart';
import 'package:remnant2_calculator/domain/calculator_cubit.dart';
import 'package:remnant2_calculator/domain/character_cubit.dart';
import 'package:remnant2_calculator/domain/effect.dart';
import 'package:remnant2_calculator/domain/item.dart';
import 'package:remnant2_calculator/extension.dart';
import 'package:remnant2_calculator/repository/amulet_repository.dart';
import 'package:remnant2_calculator/repository/archetype_repository.dart';
import 'package:remnant2_calculator/repository/hand_gun_repository.dart';
import 'package:remnant2_calculator/repository/long_gun_repository.dart';
import 'package:remnant2_calculator/repository/melee_mutator_repository.dart';
import 'package:remnant2_calculator/repository/melee_repository.dart';
import 'package:remnant2_calculator/repository/range_mutator_repository.dart';
import 'package:remnant2_calculator/repository/relic_fragment_repository.dart';
import 'package:remnant2_calculator/repository/ring_repository.dart';

class CharacterView extends StatelessWidget {
  const CharacterView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => CharacterCubit(),
        ),
        BlocProvider(
          create: (_) => CalculatorCubit(),
        ),
      ],
      child: BlocListener<CharacterCubit, CharacterState>(
        listener: (BuildContext context, state) {
          context.read<CalculatorCubit>().update(state);
        },
        child: const _CharacterView(),
      ),
    );
  }
}

class _CharacterView extends StatelessWidget {
  const _CharacterView();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _BlockLayout(
          title: '武器',
          children: [
            _WeaponView(
              title: '長槍',
              items: context.read<LongGunRepository>().getAll(),
              weaponSetter: (cubit, item) => cubit.setLongGun(item),
              weaponGetter: (state) => state.longGun,
              calculationGetter: (state) => state.longGun,
            ),
            _WeaponView(
              title: '手槍',
              items: context.read<HandGunRepository>().getAll(),
              weaponSetter: (cubit, item) => cubit.setHandGun(item),
              weaponGetter: (state) => state.handGun,
              calculationGetter: (state) => state.longGun,
            ),
            _WeaponView(
              title: '近戰',
              items: context.read<MeleeRepository>().getAll(),
              weaponSetter: (cubit, item) => cubit.setMelee(item),
              weaponGetter: (state) => state.melee,
              calculationGetter: (state) => state.melee,
            ),
          ],
        ),
        _BlockLayout(
          title: '突變因子',
          children: [
            _ItemView(
              title: '長槍突變因子',
              items: context.read<RangeMutatorRepository>().getAll(),
              setter: (cubit, item) => cubit.setLongGunMutator(item),
              getter: (state) => state.longGunMutator,
            ),
            _ItemView(
              title: '手槍突變因子',
              items: context.read<RangeMutatorRepository>().getAll(),
              setter: (cubit, item) => cubit.setHandGunMutator(item),
              getter: (state) => state.handGunMutator,
            ),
            _ItemView(
              title: '近戰突變因子',
              items: context.read<MeleeMutatorRepository>().getAll(),
              setter: (cubit, item) => cubit.setMeleeMutator(item),
              getter: (state) => state.meleeMutator,
            ),
          ],
        ),
        _BlockLayout(
          title: '職業',
          children: [
            _ItemView(
              title: '主職業',
              items: context.read<ArchetypeRepository>().getAll(),
              setter: (cubit, item) => cubit.setPrimaryArchetype(item),
              getter: (state) => state.primaryArchetype,
            ),
            _ItemView(
              title: '副職業',
              items: context.read<ArchetypeRepository>().getAll(),
              setter: (cubit, item) => cubit.setSecondaryArchetype(item),
              getter: (state) => state.secondaryArchetype,
            ),
          ],
        ),
        _BlockLayout(title: '配件', children: [
          _ItemView(
            title: '項鍊',
            items: context.read<AmuletRepository>().getAll(),
            setter: (cubit, item) => cubit.setAmulet(item),
            getter: (state) => state.amulet,
          ),
          for (var i = 0; i < 4; ++i)
            _ItemView(
              title: '戒指${i + 1}',
              items: context.read<RingRepository>().getAll(),
              setter: (cubit, item) => cubit.setRing(i, item),
              getter: (state) => state.rings[i],
            ),
        ]),
        _BlockLayout(
          title: '聖物碎片',
          children: [
            for (var i = 0; i < 3; ++i)
              _ItemView(
                title: '聖物碎片${i + 1}',
                items: context.read<RelicFragmentRepository>().getAll(),
                setter: (cubit, item) => cubit.setRelicFragment(i, item),
                getter: (state) => state.relicFragments[i],
              ),
          ],
        ),
        Container(height: 12),
      ],
    );
  }
}

class _ItemLayout extends StatelessWidget {
  const _ItemLayout({
    required this.title,
    required this.items,
    required this.getter,
    required this.setter,
    required this.itemInfo,
    super.key,
  });

  final String title;
  final List<Item> items;
  final void Function(CharacterCubit cubit, Item? item) setter;
  final Item? Function(CharacterState state) getter;
  final Widget itemInfo;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        constraints: const BoxConstraints(minWidth: 200),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(4),
              child: Text(title),
            ),
            Padding(
              padding: const EdgeInsets.all(4),
              child: BlocBuilder<CharacterCubit, CharacterState>(
                  builder: (context, state) {
                return DropdownButton(
                  items: [null, ...items]
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(e?.name ?? '空'),
                        ),
                      )
                      .toList(),
                  value: getter(state),
                  onChanged: (v) => setter(context.read<CharacterCubit>(), v),
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.all(4),
              child: IntrinsicWidth(child: itemInfo),
            ),
          ],
        ),
      ),
    );
  }
}

class _ItemView extends StatelessWidget {
  const _ItemView({
    required this.title,
    required this.items,
    required this.getter,
    required this.setter,
    super.key,
  });

  final String title;
  final List<Item> items;
  final void Function(CharacterCubit cubit, Item? item) setter;
  final Item? Function(CharacterState state) getter;

  @override
  Widget build(BuildContext context) {
    return _ItemLayout(
      title: title,
      items: items,
      getter: getter,
      setter: setter,
      itemInfo: BlocBuilder<CharacterCubit, CharacterState>(
        builder: (context, state) {
          return getter(state)?.to(
                (item) => Column(
                  children: item.effects
                      .map(
                        (e) => Text(e.displayText),
                      )
                      .toList(),
                ),
              ) ??
              Container();
        },
      ),
    );
  }
}

class _WeaponView extends StatelessWidget {
  const _WeaponView({
    super.key,
    required this.title,
    required this.items,
    required this.weaponSetter,
    required this.weaponGetter,
    required this.calculationGetter,
  });

  final String title;
  final List<Weapon> items;
  final void Function(CharacterCubit cubit, Weapon? item) weaponSetter;
  final Weapon? Function(CharacterState state) weaponGetter;
  final Calculation? Function(CalculatorState state) calculationGetter;

  @override
  Widget build(BuildContext context) {
    return _ItemLayout(
      title: title,
      items: items,
      getter: weaponGetter,
      setter: (c, i) => weaponSetter(c, i as Weapon),
      itemInfo: Builder(
        builder: (context) {
          final characterState = context.watch<CharacterCubit>().state;
          final calculatorState = context.watch<CalculatorCubit>().state;
          return weaponGetter(characterState).to(
                (item) {
                  final calculation = calculationGetter(calculatorState);
                  return Column(
                    children: [
                      const Divider(indent: 0),
                      Text(
                        '適用增傷: ${item.damage.damageTypes.displayText}',
                      ),
                      Text(
                        '基礎攻擊: ${item.damage.value}',
                      ),
                      ...item.effects.map((e) => Text(e.displayText)),
                      const Divider(),
                      Text('一般期望值: ${calculation?.expectedDamage ?? '--'}'),
                      Text(
                        '弱點期望值: ${calculation?.expectedWeakSpotDamage ?? '--'}',
                      ),
                    ],
                  );
                },
              ) ??
              Container();
        },
      ),
    );
  }
}

class _BlockLayout extends StatelessWidget {
  const _BlockLayout({super.key, required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Wrap(
          children: children
              .map(
                (element) => Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: element,
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
