import 'package:bloc/bloc.dart';
import 'package:remnant2_calculator/domain/character.dart';
import 'package:remnant2_calculator/domain/item.dart';
import 'package:remnant2_calculator/extension.dart';

class CharacterCubit extends Cubit<Character> {
  CharacterCubit() : super(Character());

  void setPrimaryArchetype(Item? item) {
    emit(state.copyWith(primaryArchetype: item));
  }

  void setSecondaryArchetype(Item? item) {
    emit(state.copyWith(secondaryArchetype: item));
  }

  void setLongGun(Weapon? item) {
    emit(state.copyWith(longGun: item));
  }

  void setLongGunMod(Weapon? item) {
    emit(state.copyWith(longGunMod: item));
  }

  void setLongGunMutator(Item? item) {
    emit(state.copyWith(longGunMutator: item));
  }

  void setHandGun(Weapon? item) {
    emit(state.copyWith(handGun: item));
  }

  void setHandGunMod(Weapon? item) {
    emit(state.copyWith(handGunMod: item));
  }

  void setHandGunMutator(Item? item) {
    emit(state.copyWith(handGunMutator: item));
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
    emit(
      state.copyWith(rings: state.rings.copyWithReplace(index, item)),
    );
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
