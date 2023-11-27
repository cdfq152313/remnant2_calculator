import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:remnant2_calculator/domain/base_damage.dart';
import 'package:remnant2_calculator/domain/effect.dart';

part 'item.g.dart';

@JsonSerializable()
class Item {
  Item({required this.name, required this.effects});

  final String name;
  final List<Effect> effects;

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}

@JsonSerializable()
class Weapon extends Item {
  Weapon({
    required super.name,
    required this.damage,
    required super.effects,
  });

  final BaseDamage damage;

  factory Weapon.fromJson(Map<String, dynamic> json) => _$WeaponFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$WeaponToJson(this);
}
