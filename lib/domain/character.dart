import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:remnant2_calculator/domain/item.dart';

part 'character.g.dart';

@CopyWith()
class Character {
  Character({
    this.firstClass,
    this.secondClass,
    this.longGun,
    this.longGunMutator,
    this.handGun,
    this.handGunMutator,
    this.melee,
    this.meleeMutator,
    this.amulet,
    this.rings = const [null, null, null, null],
    this.modifiers = const [],
  });

  final Item? firstClass;
  final Item? secondClass;

  final Item? longGun;
  final Item? longGunMutator;

  final Item? handGun;
  final Item? handGunMutator;

  final Item? melee;
  final Item? meleeMutator;

  final Item? amulet;
  final List<Item?> rings;

  final List<Item> modifiers;
}
