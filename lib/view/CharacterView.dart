import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remnant2_calculator/data/item.dart';
import 'package:remnant2_calculator/domain/calculator_cubit.dart';
import 'package:remnant2_calculator/domain/character_cubit.dart';
import 'package:remnant2_calculator/domain/item.dart';

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
    return Column(
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
      ],
    );
  }
}

class ItemView extends StatelessWidget {
  const ItemView({
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
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
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
        BlocBuilder<CharacterCubit, CharacterState>(
          builder: (context, state) {
            return Column(
              children: getter(state)
                      ?.effects
                      .map((e) => Text(e.displayText))
                      .toList() ??
                  [],
            );
          },
        ),
      ],
    );
  }
}