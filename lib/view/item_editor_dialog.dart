import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remnant2_calculator/domain/effect.dart';
import 'package:remnant2_calculator/domain/item.dart';
import 'package:remnant2_calculator/domain/item_editor_cubit.dart';
import 'package:remnant2_calculator/repository/item_repository.dart';

class ItemEditorDialog extends StatelessWidget {
  const ItemEditorDialog(this.repository, {super.key});

  final ItemRepository repository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ItemEditorCubit>(
      create: (BuildContext context) => RegularItemEditorCubit(repository),
      child: Builder(builder: (context) {
        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Text('名字'),
                  SizedBox(
                    width: 200,
                    child: TextField(
                      decoration:
                          const InputDecoration(border: OutlineInputBorder()),
                      onChanged: (v) =>
                          context.read<ItemEditorCubit>().setName(v),
                    ),
                  ),
                ],
              ),
              BlocBuilder<ItemEditorCubit, Item>(builder: (context, state) {
                return Column(
                  children: state.effects.indexed
                      .map(
                        (e) => _EffectEditor(
                          index: e.$1,
                          effect: e.$2,
                        ),
                      )
                      .toList(),
                );
              }),
              MaterialButton(
                onPressed: () => context.read<ItemEditorCubit>().addEffect(),
                child: const Row(
                  children: [
                    Icon(Icons.add),
                    Text('新增效果'),
                  ],
                ),
              ),
              Wrap(
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}

class _EffectEditor extends StatelessWidget {
  const _EffectEditor({
    required this.index,
    required this.effect,
    super.key,
  });

  final int index;
  final Effect effect;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DropdownButton(
          items: context
              .read<ItemEditorCubit>()
              .availableEffects
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(e.effectName),
                ),
              )
              .toList(),
          value: context
              .read<ItemEditorCubit>()
              .availableEffects
              .firstWhere((element) => element.caseType == effect.caseType),
          onChanged: (v) =>
              context.read<ItemEditorCubit>().editEffectType(index, v!),
        ),
        SizedBox(
          width: 200,
          child: TextField(
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^-?\d*$')),
            ],
            decoration: const InputDecoration(border: OutlineInputBorder()),
            keyboardType: const TextInputType.numberWithOptions(
                signed: true, decimal: false),
            onChanged: (v) =>
                context.read<ItemEditorCubit>().editEffectValue(index, v),
          ),
        ),
        Row(
          children: [
            Text('適用增傷'),
            ...DamageType.values
                .map(
                  (e) => Row(
                    children: [
                      Text(e.displayText),
                      Checkbox(
                        value: effect.damageTypes.contains(e),
                        onChanged: (v) => context
                            .read<ItemEditorCubit>()
                            .editEffectDamageType(index, e, v),
                      ),
                    ],
                  ),
                )
                .toList()
          ],
        ),
      ],
    );
  }
}
