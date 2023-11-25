import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remnant2_calculator/data/item.dart';
import 'package:remnant2_calculator/domain/calculator_cubit.dart';
import 'package:remnant2_calculator/domain/character_cubit.dart';

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
        ArchetypeView(),
        ArchetypeView(),
      ],
    );
  }
}

class ArchetypeView extends StatelessWidget {
  const ArchetypeView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('主職業'),
        BlocBuilder<CharacterCubit, CharacterState>(
            builder: (context, state) {
          return DropdownButton(
            items: archetypes
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(e.name),
                  ),
                )
                .toList(),
            value: state.primaryArchetype,
            onChanged: (v) =>
                context.read<CharacterCubit>().setPrimaryArchetype(v),
          );
        }),
      ],
    );
  }
}
