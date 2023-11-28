import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:remnant2_calculator/domain/item.dart';
import 'package:remnant2_calculator/repository/item_repository.dart';
import 'package:remnant2_calculator/util/auto_close.dart';

part 'item_list_cubit.freezed.dart';

class ItemListCubit<T extends Item> extends Cubit<ItemListState<T>>
    with AutoClose {
  ItemListCubit(this._itemRepository)
      : super(
          ItemListState(_itemRepository.getAll()),
        ) {
    subscriptions = [
      _itemRepository.stream.listen((event) => filter(state.keyword)),
    ];
  }

  final ItemRepository<T> _itemRepository;

  void filter(String keyword) {
    emit(
      ItemListState(
        keyword.isEmpty
            ? _itemRepository.getAll()
            : _itemRepository.filter(keyword),
        keyword: keyword,
      ),
    );
  }
}

@freezed
class ItemListState<T extends Item> with _$ItemListState {
  const factory ItemListState(
    List<T> items, {
    @Default('') String keyword,
  }) = _ItemListState;
}
