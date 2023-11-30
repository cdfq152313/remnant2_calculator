import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remnant2_calculator/domain/damage_type.dart';
import 'package:remnant2_calculator/domain/item.dart';
import 'package:remnant2_calculator/domain/item_list_cubit.dart';
import 'package:remnant2_calculator/repository/amulet_repository.dart';
import 'package:remnant2_calculator/repository/archetype_repository.dart';
import 'package:remnant2_calculator/repository/hand_gun_repository.dart';
import 'package:remnant2_calculator/repository/item_repository.dart';
import 'package:remnant2_calculator/repository/keyword_and_show_default_cubit.dart';
import 'package:remnant2_calculator/repository/long_gun_repository.dart';
import 'package:remnant2_calculator/repository/melee_repository.dart';
import 'package:remnant2_calculator/repository/mod_repository.dart';
import 'package:remnant2_calculator/repository/range_mutator_repository.dart';
import 'package:remnant2_calculator/repository/relic_fragment_repository.dart';
import 'package:remnant2_calculator/repository/ring_repository.dart';
import 'package:remnant2_calculator/view/item_editor_dialog.dart';

class ItemCollectionView extends StatelessWidget {
  const ItemCollectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => KeywordAndShowDefaultCubit(),
      child: ListView(
        children: [
          const ShowDefaultCheckbox(),
          _ItemList(
            repository: context.read<LongGunRepository>(),
            title: '長槍',
          ),
          _ItemList(
            repository: context.read<HandGunRepository>(),
            title: '手槍',
          ),
          _ItemList(
            repository: context.read<MeleeRepository>(),
            title: '近戰',
          ),
          _ItemList(
            repository: context.read<ModRepository>(),
            title: '改裝',
          ),
          _ItemList(
            repository: context.read<RangeMutatorRepository>(),
            title: '遠程突變因子',
          ),
          _ItemList(
            repository: context.read<MeleeRepository>(),
            title: '近戰突變因子',
          ),
          _ItemList(
            repository: context.read<ArchetypeRepository>(),
            title: '職業',
          ),
          _ItemList(
            repository: context.read<AmuletRepository>(),
            title: '項鍊',
          ),
          _ItemList(
            repository: context.read<RingRepository>(),
            title: '戒指',
          ),
          _ItemList(
            repository: context.read<RelicFragmentRepository>(),
            title: '聖物碎片',
          ),
          Container(height: 12),
        ],
      ),
    );
  }
}

class ShowDefaultCheckbox extends StatelessWidget {
  const ShowDefaultCheckbox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('顯示預設物品', style: Theme.of(context).textTheme.bodyLarge),
              Container(
                margin: const EdgeInsets.only(left: 8),
                child: BlocBuilder<KeywordAndShowDefaultCubit,
                    KeywordAndShowDefaultState>(
                  builder: (context, state) {
                    return Switch(
                      value: state.showDefault,
                      onChanged: (v) => context
                          .read<KeywordAndShowDefaultCubit>()
                          .setShowDefault(v),
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text('搜尋', style: Theme.of(context).textTheme.bodyLarge),
              Container(
                margin: const EdgeInsets.only(left: 8),
                child: SizedBox(
                  width: 250,
                  child: TextField(
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()),
                    onChanged: (v) => context
                        .read<KeywordAndShowDefaultCubit>()
                        .setKeyword(v),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ItemList extends StatelessWidget {
  const _ItemList({required this.repository, required this.title});

  final String title;
  final ItemRepository repository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ItemListCubit(repository),
      child: Builder(builder: (context) {
        return BlocListener<KeywordAndShowDefaultCubit,
            KeywordAndShowDefaultState>(
          listener: (BuildContext context, state) {
            context
                .read<ItemListCubit>()
                .setState(state.keyword, state.showDefault);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              BlocSelector<ItemListCubit, ItemListState, List<Item>>(
                selector: (state) => state.items,
                builder: (context, items) {
                  return Wrap(
                    children: [
                      ...items.map(
                        (item) => Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: _ItemView(item: item),
                        ),
                      ),
                      _AddItemView(repository),
                    ],
                  );
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}

class _ItemView extends StatelessWidget {
  const _ItemView({
    required this.item,
  });

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        constraints: const BoxConstraints(minWidth: 200),
        child: IntrinsicWidth(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(4),
                child: Text(item.name),
              ),
              const Divider(),
              if (item is Weapon) ...[
                Text('適用增傷 ${(item as Weapon).damage.damageTypes.displayText}'),
                Text('基礎攻擊 ${(item as Weapon).damage.value}'),
              ],
              ...item.effects.map(
                (e) => Text(e.displayText),
              ),
              if (!item.isDefault) ...[
                const Divider(),
                MaterialButton(
                  onPressed: () =>
                      context.read<ItemListCubit>().removeItem(item),
                  child: const Icon(Icons.delete),
                )
              ],
              const SizedBox(height: 4),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddItemView extends StatelessWidget {
  const _AddItemView(this.repository);

  final ItemRepository repository;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        width: 200,
        height: 100,
        child: MaterialButton(
          onPressed: () => showDialog(
            context: context,
            builder: (_) => switch (repository) {
              ItemRepository<Weapon>() =>
                WeaponEditorDialog(repository as ItemRepository<Weapon>),
              _ => ItemEditorDialog(repository),
            },
          ),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
