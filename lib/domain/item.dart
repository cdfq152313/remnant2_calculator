import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:remnant2_calculator/data/item.dart';
import 'package:remnant2_calculator/domain/base_damage.dart';
import 'package:remnant2_calculator/domain/effect.dart';

part 'item.freezed.dart';
part 'item.g.dart';

mixin _ItemField {
  String get name;

  List<Effect> get effects;
}

@freezed
class Item with _$Item, _ItemField {
  const Item._();

  const factory Item({
    required String name,
    @Default([]) List<Effect> effects,
  }) = ItemData;

  const factory Item.weapon({
    required String name,
    required BaseDamage damage,
    @Default([]) List<Effect> effects,
  }) = Weapon;

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  bool get isDefault => itemMap[name] == this;
}
