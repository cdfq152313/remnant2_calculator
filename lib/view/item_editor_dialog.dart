import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remnant2_calculator/domain/base_damage.dart';
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
    return BlocListener<ItemEditorCubit, ItemEditorState>(
      listener: (context, state) {
        if (state.finish) {
          Navigator.pop(context);
        }
      },
      child: Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '新增物品',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Row(
              children: [
                Container(
                  width: 100,
                  margin: const EdgeInsets.only(left: 8),
                  child: const Text('名字'),
                ),
                SizedBox(
                  width: 200,
                  child: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (v) =>
                        context.read<ItemEditorCubit>().setName(v),
                  ),
                ),
                BlocSelector<ItemEditorCubit, ItemEditorState, bool>(
                  selector: (state) => state.nameError,
                  builder: (context, state) {
                    return Visibility(
                      visible: state,
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
            const Divider(),
            if (context.read<ItemEditorCubit>() is WeaponEditorCubit)
              Row(
                children: [
                  Container(
                    width: 100,
                    margin: const EdgeInsets.only(left: 8),
                    child: const Text('基礎攻擊'),
                  ),
                  BlocSelector<WeaponEditorCubit, ItemEditorState<Weapon>,
                      BaseDamage>(
                    selector: (state) => state.value.damage,
                    builder: (context, state) {
                      return _NumAndCheckboxField(
                        initialValue: state.value.toString(),
                        currentDamageTypes: state.damageTypes,
                        onValueChange: (v) =>
                            context.read<WeaponEditorCubit>().setDamageValue(v),
                        onDamageTypeChange: (e, v) => context
                            .read<WeaponEditorCubit>()
                            .setDamageType(e, v),
                      );
                    },
                  ),
                ],
              ),
            const Divider(),
            BlocSelector<ItemEditorCubit, ItemEditorState, List<Effect>>(
              selector: (state) => state.value.effects,
              builder: (context, state) {
                return Column(
                  children: state.indexed
                      .map(
                        (e) => _EffectEditor(
                          index: e.$1,
                          effect: e.$2,
                        ),
                      )
                      .toList(),
                );
              },
            ),
            MaterialButton(
              onPressed: () => context.read<ItemEditorCubit>().addEffect(),
              child: const Row(
                children: [
                  Icon(Icons.add),
                  Text('新增效果'),
                ],
              ),
            ),
            SizedBox(
              height: 40,
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('取消'),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () => context.read<ItemEditorCubit>().save(),
                      child: const Text('OK'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EffectEditor extends StatelessWidget {
  const _EffectEditor({
    required this.index,
    required this.effect,
  });

  final int index;
  final Effect effect;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 8),
              width: 100,
              child: DropdownButton(
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
                    .firstWhere(
                        (element) => element.caseType == effect.caseType),
                onChanged: (v) =>
                    context.read<ItemEditorCubit>().editEffectType(index, v!),
              ),
            ),
            _NumAndCheckboxField(
              initialValue: effect.value.toString(),
              currentDamageTypes: effect.damageTypes,
              onValueChange: (v) =>
                  context.read<ItemEditorCubit>().editEffectValue(index, v),
              onDamageTypeChange: (e, v) => context
                  .read<ItemEditorCubit>()
                  .editEffectDamageType(index, e, v),
            ),
            SizedBox(
              height: 80,
              child: MaterialButton(
                onPressed: () =>
                    context.read<ItemEditorCubit>().removeEffectAt(index),
                child: const Icon(Icons.delete),
              ),
            ),
          ],
        ),
        const Divider(),
      ],
    );
  }
}

class _NumAndCheckboxField extends StatelessWidget {
  const _NumAndCheckboxField({
    super.key,
    required this.initialValue,
    required this.currentDamageTypes,
    required this.onValueChange,
    required this.onDamageTypeChange,
  });

  final String initialValue;
  final List<DamageType> currentDamageTypes;
  final void Function(String value) onValueChange;
  final void Function(DamageType damageType, bool v) onDamageTypeChange;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 200,
            child: TextFormField(
                initialValue: initialValue,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^-?\d*$')),
                ],
                decoration: const InputDecoration(border: OutlineInputBorder()),
                keyboardType: const TextInputType.numberWithOptions(
                    signed: true, decimal: false),
                onChanged: onValueChange),
          ),
          _DamageTypeCheckbox(
            currentDamageTypes: currentDamageTypes,
            onChange: onDamageTypeChange,
          )
        ],
      ),
    );
  }
}

class _DamageTypeCheckbox extends StatelessWidget {
  const _DamageTypeCheckbox({
    required this.currentDamageTypes,
    required this.onChange,
  });

  final List<DamageType> currentDamageTypes;
  final void Function(DamageType damageType, bool v) onChange;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        const Text('適用增傷: '),
        ...DamageType.values
            .map(
              (e) => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Checkbox(
                    value: currentDamageTypes.contains(e),
                    onChanged: (v) => onChange(e, v!),
                  ),
                  Text(e.displayText),
                ],
              ),
            )
            .toList()
      ],
    );
  }
}
