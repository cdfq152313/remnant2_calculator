import 'package:bloc/bloc.dart';
import 'package:remnant2_calculator/domain/base_damage.dart';
import 'package:remnant2_calculator/domain/effect.dart';
import 'package:remnant2_calculator/domain/item.dart';
import 'package:remnant2_calculator/extension.dart';
import 'package:remnant2_calculator/repository/item_repository.dart';

abstract class ItemEditorCubit<T extends Item> extends Cubit<T> {
  ItemEditorCubit(this._repository, {required T initialState})
      : super(initialState);

  final ItemRepository<Item> _repository;

  void setName(String name) {
    emit(state.copyWith(name: name) as T);
  }

  void addEffect(Effect effect) {
    emit(state.copyWith(effects: state.effects.copyWithAppend(effect)) as T);
  }

  void removeEffect(Effect effect) {
    emit(state.copyWith(effects: state.effects.copyWithRemove(effect)) as T);
  }

  void save() {
    _repository.add(state);
  }
}

class RegularItemEditorCubit extends ItemEditorCubit<Item> {
  RegularItemEditorCubit(super.repository)
      : super(initialState: const Item(name: ''));
}

class WeaponItemEditorCubit extends ItemEditorCubit<Weapon> {
  WeaponItemEditorCubit(super.repository)
      : super(
          initialState: const Weapon(name: '', damage: BaseDamage(100, [])),
        );

  void setDamage(BaseDamage damage) {
    emit(state.copyWith(damage: damage));
  }
}
