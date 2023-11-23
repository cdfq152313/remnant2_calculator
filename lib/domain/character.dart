import 'package:remnant2_calculator/domain/calculator.dart';
import 'package:remnant2_calculator/domain/item.dart';

class Character {
  Item? firstClass;
  Item? secondClass;

  Item? longGun;
  Item? longGunMutator;

  Item? handGun;
  Item? handGunMutator;

  Item? melee;
  Item? meleeMutator;

  Item? amulet;
  List<Item?> rings = [null, null, null, null];

  List<Item> modifiers = [];

  void setFirstClass(Item? value) {
    firstClass = value;
  }

  void setSecondClass(Item? value) {
    secondClass = value;
  }

  void setLongGun(Item? value) {
    longGun = value;
  }

  void setLongGunMutator(Item? value) {
    longGunMutator = value;
  }

  void setHandGun(Item? value) {
    handGun = value;
  }

  void setHandGunMutator(Item? value) {
    handGunMutator = value;
  }

  void setMelee(Item? value) {
    melee = value;
  }

  void setMeleeMutator(Item? value) {
    handGunMutator = value;
  }

  void setAmulet(Item? value) {
    amulet = value;
  }

  void setRing(int index, Item? value) {
    rings[index] = value;
  }

  void addModifier(Item item) {
    modifiers.add(item);
  }

  void removeModifier(int index) {
    modifiers.removeAt(index);
  }
}
