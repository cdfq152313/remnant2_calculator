import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remnant2_calculator/domain/calculator_cubit.dart';
import 'package:remnant2_calculator/domain/character_cubit.dart';

class CharacterView extends StatelessWidget {
  const CharacterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CharacterCubit(),
      child: BlocProvider(
        create: (_) => CalculatorCubit(),
        child: BlocListener<CharacterCubit, CharacterState>(
          listener: (BuildContext context, state) {},
        ),
      ),
    );
  }
}
