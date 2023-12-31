import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:remnant2_calculator/domain/item.dart';
import 'package:remnant2_calculator/extension.dart';

part 'build_cubit.freezed.dart';
part 'build_cubit.g.dart';

class BuildCubit extends Cubit<BuildState> {
  BuildCubit({BuildState? state}) : super(state ?? BuildState());

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

  void setPrimarySkill(Item? item) {
    emit(
      item != null && item == state.secondarySkill
          ? state.copyWith(
              primarySkill: item,
              secondarySkill: state.primarySkill,
            )
          : state.copyWith(primarySkill: item),
    );
  }

  void setSecondarySkill(Item? item) {
    emit(
      item != null && item == state.primarySkill
          ? state.copyWith(
              primarySkill: state.secondarySkill,
              secondarySkill: item,
            )
          : state.copyWith(secondarySkill: item),
    );
  }

  void setLongGun(Weapon? item) {
    emit(state.copyWith(longGun: item));
  }

  void setLongGunMod(Weapon? item) {
    if (item != null && item == state.handGunMod) {
      emit(state.copyWith(longGunMod: item, handGunMod: null));
    } else {
      emit(state.copyWith(longGunMod: item));
    }
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
    if (item != null && item == state.longGunMod) {
      emit(state.copyWith(longGunMod: null, handGunMod: item));
    } else {
      emit(state.copyWith(handGunMod: item));
    }
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

  void setLongGunModifier(Item? item) {
    emit(state.copyWith(longGunModifier: item));
  }

  void setHandGunModifier(Item? item) {
    emit(state.copyWith(handGunModifier: item));
  }

  void setState(BuildState value) {
    emit(value);
  }
}

@freezed
class BuildState with _$BuildState {
  factory BuildState({
    Item? primaryArchetype,
    Item? primarySkill,
    Item? secondaryArchetype,
    Item? secondarySkill,
    Weapon? longGun,
    Weapon? longGunMod,
    Item? longGunMutator,
    Item? longGunModifier,
    Weapon? handGun,
    Weapon? handGunMod,
    Item? handGunMutator,
    Item? handGunModifier,
    Weapon? melee,
    Item? meleeMutator,
    Item? amulet,
    @Default([null, null, null, null]) List<Item?> rings,
    @Default([null, null, null]) List<Item?> relicFragments,
    @Default([]) List<Item> regularModifiers,
  }) = _BuildState;

  factory BuildState.fromJson(Map<String, dynamic> json) =>
      _$BuildStateFromJson(json);
}
