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

  final availableEffects = [
    const DamageIncrease(0),
    const CriticalChance(0),
    const CriticalDamage(0),
    const WeakSpotDamage(0),
  ];

  void setName(String name) {
    emit(state.copyWith(name: name) as T);
  }

  void editEffectType(int index, Effect effectType) {
    final effect = effectType.copyWith(
      value: state.effects[index].value,
      damageTypes: state.effects[index].damageTypes,
    );
    emit(state.copyWith(effects: state.effects.copyWithReplace(index, effect))
        as T);
  }

  void editEffectValue(int index, String value) {
    final effect =
        state.effects[index].copyWith(value: int.tryParse(value) ?? 0);
    emit(state.copyWith(effects: state.effects.copyWithReplace(index, effect))
        as T);
  }

  void editEffectDamageType(int index, DamageType type, bool? value) {
    final effect = state.effects[index].copyWith(
      damageTypes: value ?? false
          ? state.effects[index].damageTypes.copyWithAppend(type)
          : state.effects[index].damageTypes.copyWithRemove(type),
    );
    emit(state.copyWith(effects: state.effects.copyWithReplace(index, effect))
        as T);
  }

  void addEffect() {
    emit(
      state.copyWith(
        effects: state.effects.copyWithAppend(const DamageIncrease(0)),
      ) as T,
    );
  }

  void removeEffect(Effect effect) {
    emit(state.copyWith(effects: state.effects.copyWithRemove(effect)) as T);
  }

  bool save() {
    if (state.name.trim().isEmpty) {
      return false;
    }
    _repository.add(state.copyWith(name: state.name.trim()));
    return true;
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

  void setDamageValue(String value) {
    emit(state.copyWith.damage(value: int.tryParse(value) ?? 0));
  }

  void setDamageType(DamageType type, bool? value) {
    emit(
      state.copyWith.damage(
        damageTypes: value ?? false
            ? state.damage.damageTypes.copyWithAppend(type)
            : state.damage.damageTypes.copyWithRemove(type),
      ),
    );
  }
}
