import 'package:bloc/bloc.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:remnant2_calculator/domain/item.dart';
import 'package:remnant2_calculator/extension.dart';

part 'character_cubit.g.dart';

class CharacterCubit extends Cubit<CharacterState> {
  CharacterCubit() : super(CharacterState());

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

@CopyWith()
class CharacterState {
  CharacterState({
    this.primaryArchetype,
    this.secondaryArchetype,
    this.longGun,
    this.longGunMod,
    this.longGunMutator,
    this.handGun,
    this.handGunMod,
    this.handGunMutator,
    this.melee,
    this.meleeMutator,
    this.amulet,
    this.rings = const [null, null, null, null],
    this.relicFragments = const [null, null, null],
    this.regularModifiers = const [],
    this.longGunModifiers = const [],
    this.handGunModifiers = const [],
    this.meleeModifiers = const [],
  });

  final Item? primaryArchetype;
  final Item? secondaryArchetype;

  final Weapon? longGun;
  final Weapon? longGunMod;
  final Item? longGunMutator;
  final List<Item> longGunModifiers;

  final Weapon? handGun;
  final Weapon? handGunMod;
  final Item? handGunMutator;
  final List<Item> handGunModifiers;

  final Weapon? melee;
  final Item? meleeMutator;
  final List<Item> meleeModifiers;

  final Item? amulet;
  final List<Item?> rings;

  final List<Item?> relicFragments;
  final List<Item> regularModifiers;
}
