import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remnant2_calculator/domain/item.dart';
import 'package:remnant2_calculator/domain/item_list_cubit.dart';
import 'package:remnant2_calculator/repository/amulet_repository.dart';
import 'package:remnant2_calculator/repository/archetype_repository.dart';
import 'package:remnant2_calculator/repository/hand_gun_repository.dart';
import 'package:remnant2_calculator/repository/item_repository.dart';
import 'package:remnant2_calculator/repository/long_gun_repository.dart';
import 'package:remnant2_calculator/repository/melee_repository.dart';
import 'package:remnant2_calculator/repository/range_mutator_repository.dart';
import 'package:remnant2_calculator/repository/relic_fragment_repository.dart';
import 'package:remnant2_calculator/repository/ring_repository.dart';
import 'package:remnant2_calculator/repository/show_default_cubit.dart';

class ItemCollectionView extends StatelessWidget {
  const ItemCollectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ShowDefaultCubit(true),
      child: ListView(
        children: [
          const ShowDefaultCheckbox(),
          _ItemList(repository: context.read<LongGunRepository>(), title: '長槍'),
          _ItemList(repository: context.read<HandGunRepository>(), title: '手槍'),
          _ItemList(repository: context.read<MeleeRepository>(), title: '近戰'),
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
      child: Row(
        children: [
          Text('顯示預設物品', style: Theme.of(context).textTheme.titleMedium),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child:
                BlocBuilder<ShowDefaultCubit, bool>(builder: (context, state) {
              return Switch(
                value: state,
                onChanged: (v) => context.read<ShowDefaultCubit>().set(v),
              );
            }),
          )
        ],
      ),
    );
  }
}

class _ItemList extends StatelessWidget {
  const _ItemList({super.key, required this.repository, required this.title});

  final String title;
  final ItemRepository<Item> repository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ItemListCubit(repository),
      child: Builder(builder: (context) {
        return BlocListener<ShowDefaultCubit, bool>(
          listener: (BuildContext context, state) {
            context.read<ItemListCubit>().setShowDefault(state);
          },
          child: BlocBuilder<ItemListCubit, ItemListState>(
            builder: (context, state) {
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
                    children: state.items
                        .map(
                          (item) => Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: _ItemView(item: item),
                          ),
                        )
                        .toList(),
                  ),
                ],
              );
            },
          ),
        );
      }),
    );
  }
}

class _ItemView extends StatelessWidget {
  const _ItemView({
    super.key,
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
              ...item.effects.map(
                (e) => Text(e.displayText),
              ),
              const SizedBox(height: 4),
            ],
          ),
        ),
      ),
    );
  }
}
