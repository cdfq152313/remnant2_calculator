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
      _itemRepository.stream.listen((event) => update()),
    ];
  }

  final ItemRepository<T> _itemRepository;

  void setKeyword(String keyword) {
    _update(keyword, state.showDefault);
  }

  void setShowDefault(bool value) {
    _update(state.keyword, value);
  }

  void setState(String keyword, bool value) {
    _update(keyword, value);
  }

  void update() {
    _update(state.keyword, state.showDefault);
  }

  void _update(String keyword, bool showDefault) {
    emit(
      ItemListState(
        switch ((keyword.isEmpty, showDefault)) {
          (true, true) => _itemRepository.getAll(),
          (true, false) => _itemRepository.getAllCustomized(),
          (false, true) => _itemRepository.filter(keyword),
          (false, false) => _itemRepository.filterCustomized(keyword),
        },
        keyword: keyword,
        showDefault: showDefault,
      ),
    );
  }
}

@freezed
class ItemListState<T extends Item> with _$ItemListState {
  const factory ItemListState(
    List<T> items, {
    @Default(true) bool showDefault,
    @Default('') String keyword,
  }) = _ItemListState;
}
