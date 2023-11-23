import 'package:remnant2_calculator/domain/item.dart';

class Character {
  Item? longGun;
  Item? handGun;
  Item? melee;

  Item? amulet;
  List<Item?> rings = [null, null, null, null];

  void setLongGun(Item? value) {
    longGun = value;
  }

  void setHandGun(Item? value) {
    handGun = value;
  }

  void setMelee(Item? value) {
    melee = value;
  }

  void setAmulet(Item? value) {
    amulet = value;
  }

  void setRing(int index, Item? value) {
    rings[index] = value;
  }
}
