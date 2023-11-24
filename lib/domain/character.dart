import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:remnant2_calculator/domain/item.dart';

part 'character.g.dart';

@CopyWith()
class Character {
  Character({
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
