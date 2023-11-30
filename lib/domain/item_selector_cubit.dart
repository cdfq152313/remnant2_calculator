import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:remnant2_calculator/domain/item.dart';
import 'package:remnant2_calculator/repository/item_repository.dart';

part 'item_selector_cubit.freezed.dart';

class ItemSelectorCubit extends Cubit<ItemSelectorState> {
  ItemSelectorCubit(this._repository)
      : super(ItemSelectorState(keyword: '', items: _repository.getAll()));

  final ItemRepository _repository;

  void setKeyword(String keyword) {
    emit(
      ItemSelectorState(
          keyword: keyword,
          items: keyword.isEmpty
              ? _repository.getAll()
              : _repository.filter(keyword)),
    );
  }
}

@freezed
class ItemSelectorState with _$ItemSelectorState {
  const factory ItemSelectorState({
    required String keyword,
    required List<Item> items,
  }) = _ItemSelectorState;
}
