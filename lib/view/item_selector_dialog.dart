import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remnant2_calculator/domain/item.dart';
import 'package:remnant2_calculator/domain/item_selector_cubit.dart';
import 'package:remnant2_calculator/repository/item_repository.dart';

class ItemSelectorDialog extends StatelessWidget {
  const ItemSelectorDialog(
    this.repository, {
    super.key,
    required this.onChanged,
  });

  final ItemRepository repository;
  final void Function(Item? v) onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ItemSelectorCubit(repository),
      child: _ItemSelectorDialog(onChanged: onChanged),
    );
  }
}

class _ItemSelectorDialog extends StatelessWidget {
  const _ItemSelectorDialog({required this.onChanged});

  final void Function(Item? v) onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemSelectorCubit, ItemSelectorState>(
      builder: (context, state) {
        return SimpleDialog(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: TextField(
                onChanged: (v) =>
                    context.read<ItemSelectorCubit>().setKeyword(v),
                decoration: const InputDecoration(hintText: '搜尋'),
              ),
            ),
            SimpleDialogOption(
              child: const Text('空'),
              onPressed: () {
                onChanged(null);
                Navigator.of(context).pop();
              },
            ),
            ...state.items.map(
              (e) => SimpleDialogOption(
                child: Text(e.name),
                onPressed: () {
                  onChanged(e);
                  Navigator.of(context).pop();
                },
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('取消'),
            ),
          ],
        );
      },
    );
  }
}
