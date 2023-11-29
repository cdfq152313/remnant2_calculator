import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:remnant2_calculator/domain/base_damage.dart';
import 'package:remnant2_calculator/domain/effect.dart';
import 'package:remnant2_calculator/domain/item.dart';
import 'package:remnant2_calculator/extension.dart';
import 'package:remnant2_calculator/repository/item_repository.dart';

part 'item_editor_cubit.freezed.dart';

abstract class ItemEditorCubit<T extends Item>
    extends Cubit<ItemEditorState<T>> {
  ItemEditorCubit(this._repository, {required ItemEditorState<T> initialState})
      : super(initialState);

  final ItemRepository<Item> _repository;

  final availableEffects = [
    const DamageIncrease(0),
    const CriticalChance(0),
    const CriticalDamage(0),
    const WeakSpotDamage(0),
  ];

  void setName(String name) {
    emit(ItemEditorState(state.value.copyWith(name: name) as T));
  }

  void editEffectType(int index, Effect effectType) {
    final effect = effectType.copyWith(
      value: state.value.effects[index].value,
      damageTypes: state.value.effects[index].damageTypes,
    );
    emit(ItemEditorState(state.value.copyWith(
        effects: state.value.effects.copyWithReplace(index, effect)) as T));
  }

  void editEffectValue(int index, String value) {
    final effect =
        state.value.effects[index].copyWith(value: int.tryParse(value) ?? 0);
    emit(ItemEditorState(state.value.copyWith(
        effects: state.value.effects.copyWithReplace(index, effect)) as T));
  }

  void editEffectDamageType(int index, DamageType type, bool? value) {
    final effect = state.value.effects[index].copyWith(
      damageTypes: value ?? false
          ? state.value.effects[index].damageTypes.copyWithAppend(type)
          : state.value.effects[index].damageTypes.copyWithRemove(type),
    );
    emit(ItemEditorState(state.value.copyWith(
        effects: state.value.effects.copyWithReplace(index, effect)) as T));
  }

  void addEffect() {
    emit(
      ItemEditorState(state.value.copyWith(
        effects: state.value.effects.copyWithAppend(const DamageIncrease(0)),
      ) as T),
    );
  }

  void removeEffectAt(int index) {
    emit(
      ItemEditorState(state.value
          .copyWith(effects: state.value.effects.copyWithRemoveAt(index)) as T),
    );
  }

  void save() {
    if (state.value.name.trim().isEmpty) {
      emit(state.copyWith(nameError: true));
      return;
    }
    _repository.add(state.value.copyWith(name: state.value.name.trim()));
    emit(state.copyWith(finish: true));
  }
}

@freezed
sealed class ItemEditorState<T extends Item> with _$ItemEditorState<T> {
  const factory ItemEditorState(
    final T value, {
    @Default(false) bool nameError,
    @Default(false) bool finish,
  }) = _ItemEditorState;
}

class RegularItemEditorCubit extends ItemEditorCubit<Item> {
  RegularItemEditorCubit(super.repository)
      : super(initialState: const ItemEditorState(Item(name: '')));
}

class WeaponEditorCubit extends ItemEditorCubit<Weapon> {
  WeaponEditorCubit(super.repository)
      : super(
          initialState: const ItemEditorState(
              Weapon(name: '', damage: BaseDamage(100, []))),
        );

  void setDamageValue(String value) {
    emit(
      ItemEditorState(
          state.value.copyWith.damage(value: int.tryParse(value) ?? 0)),
    );
  }

  void setDamageType(DamageType type, bool? value) {
    emit(
      ItemEditorState(state.value.copyWith.damage(
        damageTypes: value ?? false
            ? state.value.damage.damageTypes.copyWithAppend(type)
            : state.value.damage.damageTypes.copyWithRemove(type),
      )),
    );
  }
}
