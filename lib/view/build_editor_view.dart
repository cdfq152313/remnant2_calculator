import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remnant2_calculator/domain/build_cubit.dart';
import 'package:remnant2_calculator/domain/build_record_cubit.dart';
import 'package:remnant2_calculator/domain/calculator.dart';
import 'package:remnant2_calculator/domain/calculator_cubit.dart';
import 'package:remnant2_calculator/domain/damage_type.dart';
import 'package:remnant2_calculator/domain/item.dart';
import 'package:remnant2_calculator/domain/select_build_cubit.dart';
import 'package:remnant2_calculator/repository/amulet_repository.dart';
import 'package:remnant2_calculator/repository/archetype_repository.dart';
import 'package:remnant2_calculator/repository/hand_gun_repository.dart';
import 'package:remnant2_calculator/repository/item_repository.dart';
import 'package:remnant2_calculator/repository/long_gun_repository.dart';
import 'package:remnant2_calculator/repository/melee_mutator_repository.dart';
import 'package:remnant2_calculator/repository/melee_repository.dart';
import 'package:remnant2_calculator/repository/range_mutator_repository.dart';
import 'package:remnant2_calculator/repository/relic_fragment_repository.dart';
import 'package:remnant2_calculator/repository/ring_repository.dart';
import 'package:remnant2_calculator/view/item_selector_dialog.dart';

class BuildEditorView extends StatefulWidget {
  const BuildEditorView({super.key});

  @override
  State<BuildEditorView> createState() => _BuildEditorViewState();
}

class _BuildEditorViewState extends State<BuildEditorView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => BuildCubit(),
        ),
        BlocProvider(
          create: (_) => CalculatorCubit(),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<SelectBuildCubit, BuildState?>(
            listener: (BuildContext context, state) {
              if (state != null) {
                context.read<BuildCubit>().setState(state);
              }
            },
          ),
          BlocListener<BuildCubit, BuildState>(
            listener: (BuildContext context, state) {
              context.read<CalculatorCubit>().update(state);
            },
          ),
        ],
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
        TextButton(
          child: const Row(
            children: [
              Padding(
                padding: EdgeInsets.all(4),
                child: Icon(Icons.save),
              ),
              Text('儲存套裝'),
            ],
          ),
          onPressed: () {
            context
                .read<BuildRecordCubit>()
                .add(context.read<BuildCubit>().state);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('儲存成功')),
            );
          },
        ),
        _BlockLayout(
          title: '武器',
          children: [
            _WeaponView(
              title: '長槍',
              repository: context.read<LongGunRepository>(),
              weaponSelector: (state) => state.longGun,
              calculationSelector: (state) => state.longGun,
              onChange: (item) => context.read<BuildCubit>().setLongGun(item),
            ),
            _WeaponView(
              title: '手槍',
              repository: context.read<HandGunRepository>(),
              weaponSelector: (state) => state.handGun,
              calculationSelector: (state) => state.handGun,
              onChange: (item) => context.read<BuildCubit>().setHandGun(item),
            ),
            _WeaponView(
              title: '近戰',
              repository: context.read<MeleeRepository>(),
              weaponSelector: (state) => state.melee,
              calculationSelector: (state) => state.melee,
              onChange: (item) => context.read<BuildCubit>().setMelee(item),
            ),
          ],
        ),
        _BlockLayout(
          title: '突變因子',
          children: [
            _ItemView(
              title: '長槍突變因子',
              repository: context.read<RangeMutatorRepository>(),
              selector: (state) => state.longGunMutator,
              onChange: (item) =>
                  context.read<BuildCubit>().setLongGunMutator(item),
            ),
            _ItemView(
              title: '手槍突變因子',
              repository: context.read<RangeMutatorRepository>(),
              selector: (state) => state.handGunMutator,
              onChange: (item) =>
                  context.read<BuildCubit>().setHandGunMutator(item),
            ),
            _ItemView(
              title: '近戰突變因子',
              repository: context.read<MeleeMutatorRepository>(),
              selector: (state) => state.meleeMutator,
              onChange: (item) =>
                  context.read<BuildCubit>().setMeleeMutator(item),
            ),
          ],
        ),
        _BlockLayout(
          title: '職業',
          children: [
            _ItemView(
              title: '主職業',
              repository: context.read<ArchetypeRepository>(),
              selector: (state) => state.primaryArchetype,
              onChange: (item) =>
                  context.read<BuildCubit>().setPrimaryArchetype(item),
            ),
            _ItemView(
              title: '副職業',
              repository: context.read<ArchetypeRepository>(),
              selector: (state) => state.secondaryArchetype,
              onChange: (item) =>
                  context.read<BuildCubit>().setSecondaryArchetype(item),
            ),
          ],
        ),
        _BlockLayout(title: '配件', children: [
          _ItemView(
            title: '項鍊',
            repository: context.read<AmuletRepository>(),
            selector: (state) => state.amulet,
            onChange: (item) => context.read<BuildCubit>().setAmulet(item),
          ),
          for (var i = 0; i < 4; ++i)
            _ItemView(
              title: '戒指${i + 1}',
              repository: context.read<RingRepository>(),
              selector: (state) => state.rings[i],
              onChange: (item) => context.read<BuildCubit>().setRing(i, item),
            ),
        ]),
        _BlockLayout(
          title: '聖物碎片',
          children: [
            for (var i = 0; i < 3; ++i)
              _ItemView(
                title: '聖物碎片${i + 1}',
                repository: context.read<RelicFragmentRepository>(),
                selector: (state) => state.relicFragments[i],
                onChange: (item) =>
                    context.read<BuildCubit>().setRelicFragment(i, item),
              ),
          ],
        ),
        Container(height: 12),
      ],
    );
  }
}

class _ItemLayout<T extends Item> extends StatelessWidget {
  const _ItemLayout({
    required this.title,
    required this.name,
    required this.repository,
    required this.onChange,
    required this.itemInfo,
  });

  final String title;
  final String? name;
  final ItemRepository<T> repository;
  final void Function(T? item) onChange;
  final Widget itemInfo;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        constraints: const BoxConstraints(minWidth: 200),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: Text(title),
                ),
                TextButton(
                  onPressed: () => showDialog(
                    context: context,
                    builder: (_) => ItemSelectorDialog(
                      repository,
                      onChanged: (v) => onChange(v as T?),
                    ),
                  ),
                  child: const Text('選擇'),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(4),
              child: Text(name ?? '空'),
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
    required this.repository,
    required this.selector,
    required this.onChange,
  });

  final String title;
  final ItemRepository<Item> repository;
  final Item? Function(BuildState state) selector;
  final void Function(Item? item) onChange;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<BuildCubit, BuildState, Item?>(
      selector: selector,
      builder: (context, state) {
        return _ItemLayout(
          title: title,
          name: state?.name,
          repository: repository,
          onChange: onChange,
          itemInfo: state == null
              ? Container()
              : Column(
                  children: state.effects
                      .map(
                        (e) => Text(e.displayText),
                      )
                      .toList(),
                ),
        );
      },
    );
  }
}

class _WeaponView extends StatelessWidget {
  const _WeaponView({
    required this.title,
    required this.repository,
    required this.weaponSelector,
    required this.calculationSelector,
    required this.onChange,
  });

  final String title;
  final ItemRepository<Weapon> repository;
  final Weapon? Function(BuildState state) weaponSelector;
  final Calculation? Function(CalculatorState state) calculationSelector;
  final void Function(Weapon? item) onChange;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<BuildCubit, BuildState, Weapon?>(
      selector: weaponSelector,
      builder: (context, state) {
        return _ItemLayout(
          title: title,
          repository: repository,
          name: state?.name,
          onChange: onChange,
          itemInfo: Builder(
            builder: (context) {
              final item = context.select<BuildCubit, Weapon?>(
                (cubit) => weaponSelector(cubit.state),
              );
              final calculation = context.select<CalculatorCubit, Calculation?>(
                (cubit) => calculationSelector(cubit.state),
              );
              if (item == null || calculation == null) {
                return Container();
              }
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
                  Text('一般期望值: ${calculation.expectedDamage ?? '--'}'),
                  Text(
                    '弱點期望值: ${calculation.expectedWeakSpotDamage ?? '--'}',
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}

class _BlockLayout extends StatelessWidget {
  const _BlockLayout({required this.title, required this.children});

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
