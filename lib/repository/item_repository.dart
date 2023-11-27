import 'package:remnant2_calculator/data/item.dart';
import 'package:remnant2_calculator/domain/item.dart';

class ItemRepository {
  List<Item> getArchetypes() {
    return archetypes;
  }

  List<Item> getModifiers() {
    return modifiers;
  }

  List<Weapon> getLongGuns() {
    return longGuns;
  }

  List<Weapon> getHandGuns() {
    return handGuns;
  }

  List<Weapon> getMelees() {
    return melees;
  }

  List<Item> getAmulets() {
    return amulets;
  }

  List<Item> getRings() {
    return rings;
  }

  List<Item> getRelicFragments() {
    return relicFragments;
  }

  List<Item> getRangeMutators() {
    return rangeMutator;
  }

  List<Item> getMeleeMutators() {
    return meleeMutator;
  }
}
