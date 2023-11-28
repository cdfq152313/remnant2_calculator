import 'package:bloc/bloc.dart';
import 'package:remnant2_calculator/domain/effect.dart';
import 'package:remnant2_calculator/domain/item.dart';
import 'package:remnant2_calculator/extension.dart';
import 'package:remnant2_calculator/repository/item_repository.dart';

class ItemEditorCubit extends Cubit<Item> {
  ItemEditorCubit(this._repository) : super(const Item(name: ''));

  final ItemRepository<Item> _repository;

  void setName(String name) {
    emit(state.copyWith(name: name));
  }

  void addEffect(Effect effect) {
    emit(state.copyWith(effects: state.effects.copyWithAppend(effect)));
  }

  void removeEffect(Effect effect) {
    emit(state.copyWith(effects: state.effects.copyWithRemove(effect)));
  }

  void save() {
    _repository.add(state);
  }
}
