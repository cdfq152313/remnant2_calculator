import 'package:bloc/bloc.dart';
import 'package:remnant2_calculator/domain/base_damage.dart';
import 'package:remnant2_calculator/domain/effect.dart';
import 'package:remnant2_calculator/domain/item.dart';
import 'package:remnant2_calculator/extension.dart';
import 'package:remnant2_calculator/repository/item_repository.dart';

class WeaponEditorCubit extends Cubit<Weapon> {
  WeaponEditorCubit(this._repository)
      : super(
          const Weapon(name: '', damage: BaseDamage(100, [])),
        );

  final ItemRepository<Weapon> _repository;

  void setName(String name) {
    emit(state.copyWith(name: name));
  }

  void addEffect(Effect effect) {
    emit(state.copyWith(effects: state.effects.copyWithAppend(effect)));
  }

  void removeEffect(Effect effect) {
    emit(state.copyWith(effects: state.effects.copyWithRemove(effect)));
  }

  void setDamage(BaseDamage damage) {
    emit(state.copyWith(damage: damage));
  }

  void save() {
    _repository.add(state);
  }
}
