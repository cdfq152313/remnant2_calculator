import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remnant2_calculator/data/item.dart';
import 'package:remnant2_calculator/domain/calculator.dart';
import 'package:remnant2_calculator/domain/calculator_cubit.dart';
import 'package:remnant2_calculator/domain/character_cubit.dart';
import 'package:remnant2_calculator/domain/effect.dart';
import 'package:remnant2_calculator/domain/item.dart';
import 'package:remnant2_calculator/extension.dart';

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
            WeaponView(
              title: '長槍',
              items: longGuns,
              weaponSetter: (cubit, item) => cubit.setLongGun(item as Weapon),
              weaponGetter: (state) => state.longGun,
              calculationGetter: (state) => state.longGun,
            ),
            WeaponView(
              title: '手槍',
              items: handGuns,
              weaponSetter: (cubit, item) => cubit.setHandGun(item as Weapon),
              weaponGetter: (state) => state.handGun,
              calculationGetter: (state) => state.longGun,
            ),
            ItemView(
              title: '近戰',
              items: melees,
              setter: (cubit, item) => cubit.setMelee(item as Weapon),
              getter: (state) => state.melee,
            ),
          ],
        ),
        _BlockLayout(
          title: '突變因子',
          children: [
            ItemView(
              title: '長槍突變因子',
              items: rangeMutator,
              setter: (cubit, item) => cubit.setLongGunMutator(item),
              getter: (state) => state.longGunMutator,
            ),
            ItemView(
              title: '手槍突變因子',
              items: rangeMutator,
              setter: (cubit, item) => cubit.setHandGunMutator(item),
              getter: (state) => state.handGunMutator,
            ),
            ItemView(
              title: '近戰突變因子',
              items: meleeMutator,
              setter: (cubit, item) => cubit.setMeleeMutator(item),
              getter: (state) => state.meleeMutator,
            ),
          ],
        ),
        _BlockLayout(
          title: '職業',
          children: [
            ItemView(
              title: '主職業',
              items: archetypes,
              setter: (cubit, item) => cubit.setPrimaryArchetype(item),
              getter: (state) => state.primaryArchetype,
            ),
            ItemView(
              title: '副職業',
              items: archetypes,
              setter: (cubit, item) => cubit.setSecondaryArchetype(item),
              getter: (state) => state.secondaryArchetype,
            ),
          ],
        ),
        _BlockLayout(title: '配件', children: [
          ItemView(
            title: '項鍊',
            items: amulets,
            setter: (cubit, item) => cubit.setAmulet(item),
            getter: (state) => state.amulet,
          ),
          for (var i = 0; i < 4; ++i)
            ItemView(
              title: '戒指${i + 1}',
              items: rings,
              setter: (cubit, item) => cubit.setRing(i, item),
              getter: (state) => state.rings[i],
            ),
        ]),
        _BlockLayout(
          title: '聖物碎片',
          children: [
            for (var i = 0; i < 3; ++i)
              ItemView(
                title: '聖物碎片${i + 1}',
                items: relicFragments,
                setter: (cubit, item) => cubit.setRelicFragment(i, item),
                getter: (state) => state.relicFragments[i],
              ),
          ],
        ),
      ],
    );
  }
}

class WeaponView extends StatelessWidget {
  const WeaponView({
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
    return ItemView(
      title: title,
      items: items,
      getter: weaponGetter,
      setter: (c, i) => weaponSetter(c, i as Weapon),
      additionalInfo: Builder(
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
                        '適用增傷: ${item.damageTypes.map((e) => e.displayText).join(',')}',
                      ),
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

class ItemView extends StatelessWidget {
  const ItemView({
    required this.title,
    required this.items,
    required this.getter,
    required this.setter,
    this.additionalInfo,
    super.key,
  });

  final String title;
  final List<Item> items;
  final void Function(CharacterCubit cubit, Item? item) setter;
  final Item? Function(CharacterState state) getter;
  final Widget? additionalInfo;

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
              child: BlocBuilder<CharacterCubit, CharacterState>(
                builder: (context, state) {
                  final item = getter(state);
                  return IntrinsicWidth(
                    child: Column(
                      children: [
                        if (item != null)
                          ...item.effects.map(
                            (e) => Text(e.displayText),
                          ),
                        if (additionalInfo != null) additionalInfo!,
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
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
