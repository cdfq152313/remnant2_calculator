import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:remnant2_calculator/domain/item.dart';
import 'package:remnant2_calculator/extension.dart';

part 'character_cubit.freezed.dart';
part 'character_cubit.g.dart';

class CharacterCubit extends Cubit<CharacterState> {
  CharacterCubit({CharacterState? state}) : super(state ?? CharacterState());

  void setPrimaryArchetype(Item? item) {
    emit(
      item != null && item == state.secondaryArchetype
          ? state.copyWith(
              primaryArchetype: item,
              secondaryArchetype: state.primaryArchetype,
            )
          : state.copyWith(primaryArchetype: item),
    );
  }

  void setSecondaryArchetype(Item? item) {
    emit(
      item != null && item == state.primaryArchetype
          ? state.copyWith(
              primaryArchetype: state.secondaryArchetype,
              secondaryArchetype: item,
            )
          : state.copyWith(secondaryArchetype: item),
    );
  }

  void setLongGun(Weapon? item) {
    emit(state.copyWith(longGun: item));
  }

  void setLongGunMod(Weapon? item) {
    emit(state.copyWith(longGunMod: item));
  }

  void setLongGunMutator(Item? item) {
    if (item != null && item == state.handGunMutator) {
      emit(state.copyWith(longGunMutator: item, handGunMutator: null));
    } else {
      emit(state.copyWith(longGunMutator: item));
    }
  }

  void setHandGun(Weapon? item) {
    emit(state.copyWith(handGun: item));
  }

  void setHandGunMod(Weapon? item) {
    emit(state.copyWith(handGunMod: item));
  }

  void setHandGunMutator(Item? item) {
    if (item != null && item == state.longGunMutator) {
      emit(state.copyWith(longGunMutator: null, handGunMutator: item));
    } else {
      emit(state.copyWith(handGunMutator: item));
    }
  }

  void setMelee(Weapon? item) {
    emit(state.copyWith(melee: item));
  }

  void setMeleeMutator(Item? item) {
    emit(state.copyWith(meleeMutator: item));
  }

  void setAmulet(Item? item) {
    emit(state.copyWith(amulet: item));
  }

  void setRing(int index, Item? item) {
    emit(state.copyWith(rings: _setAndSwitch(index, item, state.rings)));
  }

  void setRelicFragment(int index, Item? item) {
    emit(
      state.copyWith(
        relicFragments: _setAndSwitch(index, item, state.relicFragments),
      ),
    );
  }

  List<Item?> _setAndSwitch(int index, Item? item, List<Item?> origin) {
    final copy = origin.toList();
    final existIndex = item == null ? -1 : copy.indexOf(item);
    if (existIndex != -1) {
      copy[existIndex] = copy[index];
    }
    copy[index] = item;
    return copy;
  }

  void addRegularModifier(Item item) {
    emit(
      state.copyWith(
        regularModifiers: state.regularModifiers.copyWithAppend(item),
      ),
    );
  }

  void removeRegularModifier(int index) {
    emit(
      state.copyWith(
        regularModifiers: state.regularModifiers.copyWithRemoveAt(index),
      ),
    );
  }

  void addLongGunModifier(Item item) {
    emit(
      state.copyWith(
        longGunModifiers: state.longGunModifiers.copyWithAppend(item),
      ),
    );
  }

  void removeLongGunModifier(int index) {
    emit(
      state.copyWith(
        longGunModifiers: state.longGunModifiers.copyWithRemoveAt(index),
      ),
    );
  }

  void addHandGunModifier(Item item) {
    emit(
      state.copyWith(
        handGunModifiers: state.handGunModifiers.copyWithAppend(item),
      ),
    );
  }

  void removeHandGunModifier(int index) {
    emit(
      state.copyWith(
        handGunModifiers: state.handGunModifiers.copyWithRemoveAt(index),
      ),
    );
  }

  void addMeleeModifier(Item item) {
    emit(
      state.copyWith(meleeModifiers: state.meleeModifiers.copyWithAppend(item)),
    );
  }

  void removeMeleeModifier(int index) {
    emit(
      state.copyWith(
          meleeModifiers: state.meleeModifiers.copyWithRemoveAt(index)),
    );
  }
}

@freezed
class CharacterState with _$CharacterState {
  factory CharacterState({
    Item? primaryArchetype,
    Item? secondaryArchetype,
    Weapon? longGun,
    Weapon? longGunMod,
    Item? longGunMutator,
    @Default([]) List<Item> longGunModifiers,
    Weapon? handGun,
    Weapon? handGunMod,
    Item? handGunMutator,
    @Default([]) List<Item> handGunModifiers,
    Weapon? melee,
    Item? meleeMutator,
    @Default([]) List<Item> meleeModifiers,
    Item? amulet,
    @Default([null, null, null, null]) List<Item?> rings,
    @Default([null, null, null]) List<Item?> relicFragments,
    @Default([]) List<Item> regularModifiers,
  }) = _CharacterState;

  factory CharacterState.fromJson(Map<String, dynamic> json) =>
      _$CharacterStateFromJson(json);
}
