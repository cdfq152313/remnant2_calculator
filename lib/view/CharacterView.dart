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
  const _CharacterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ArchetypeView(
          title: '主職業',
          setter: (cubit, item) => cubit.setPrimaryArchetype(item),
          getter: (state) => state.primaryArchetype,
        ),
        ArchetypeView(
          title: '副職業',
          setter: (cubit, item) => cubit.setSecondaryArchetype(item),
          getter: (state) => state.secondaryArchetype,
        ),
      ],
    );
  }
}

class ArchetypeView extends StatelessWidget {
  const ArchetypeView({
    required this.title,
    required this.getter,
    required this.setter,
    super.key,
  });

  final String title;
  final void Function(CharacterCubit cubit, Item? item) setter;
  final Item? Function(CharacterState state) getter;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title),
        BlocBuilder<CharacterCubit, CharacterState>(builder: (context, state) {
          return DropdownButton(
            items: archetypes
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(e.name),
                  ),
                )
                .toList(),
            value: getter(state),
            onChanged: (v) => setter(context.read<CharacterCubit>(), v),
          );
        }),
      ],
    );
  }
}
