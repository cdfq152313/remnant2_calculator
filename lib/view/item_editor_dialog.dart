import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remnant2_calculator/domain/effect.dart';
import 'package:remnant2_calculator/domain/item.dart';
import 'package:remnant2_calculator/domain/item_editor_cubit.dart';
import 'package:remnant2_calculator/repository/item_repository.dart';

class ItemEditorDialog extends StatelessWidget {
  const ItemEditorDialog(this.repository, {super.key});

  final ItemRepository<Item> repository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ItemEditorCubit>(
      create: (BuildContext context) => RegularItemEditorCubit(repository),
      child: _ItemEditorDialog(),
    );
  }
}

class WeaponEditorDialog extends StatelessWidget {
  const WeaponEditorDialog(this.repository, {super.key});

  final ItemRepository<Weapon> repository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => WeaponEditorCubit(repository),
      child: Builder(builder: (context) {
        return BlocProvider<ItemEditorCubit>.value(
          value: BlocProvider.of<WeaponEditorCubit>(context),
          child: _ItemEditorDialog(),
        );
      }),
    );
  }
}

class _ItemEditorDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (v) => context.read<ItemEditorCubit>().setName(v),
                ),
              ),
              BlocBuilder<ItemEditorCubit, ItemEditorState>(
                builder: (context, state) {
                  return Visibility(
                    visible: state.nameError,
                    child: Text(
                      '名稱不得為空',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.error),
                    ),
                  );
                },
              ),
            ],
          ),
          if (context.read<ItemEditorCubit>() is WeaponEditorCubit)
            BlocBuilder<WeaponEditorCubit, ItemEditorState<Weapon>>(
              builder: (context, state) {
                return Row(
                  children: [
                    const Text('基礎攻擊'),
                    SizedBox(
                      width: 200,
                      child: TextFormField(
                        initialValue: state.value.damage.value.toString(),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (v) =>
                            context.read<WeaponEditorCubit>().setDamageValue(v),
                      ),
                    ),
                    _DamageTypeCheckbox(
                      currentDamageTypes: state.value.damage.damageTypes,
                      onChange: (e, v) =>
                          context.read<WeaponEditorCubit>().setDamageType(e, v),
                    ),
                  ],
                );
              },
            ),
          const Divider(),
          BlocBuilder<ItemEditorCubit, ItemEditorState>(
              builder: (context, state) {
            return Column(
              children: state.value.effects.indexed
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
                onPressed: () => context.read<ItemEditorCubit>().save(),
                child: const Text('OK'),
              ),
            ],
          ),
        ],
      ),
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
          child: TextFormField(
            initialValue: effect.value.toString(),
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
        _DamageTypeCheckbox(
          currentDamageTypes: effect.damageTypes,
          onChange: (e, v) =>
              context.read<ItemEditorCubit>().editEffectDamageType(index, e, v),
        ),
      ],
    );
  }
}

class _DamageTypeCheckbox extends StatelessWidget {
  const _DamageTypeCheckbox({
    super.key,
    required this.currentDamageTypes,
    required this.onChange,
  });

  final List<DamageType> currentDamageTypes;
  final void Function(DamageType damageType, bool v) onChange;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('適用增傷: '),
        ...DamageType.values
            .map(
              (e) => Row(
                children: [
                  Text(e.displayText),
                  Checkbox(
                    value: currentDamageTypes.contains(e),
                    onChanged: (v) => onChange(e, v!),
                  ),
                ],
              ),
            )
            .toList()
      ],
    );
  }
}