import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:remnant2_calculator/domain/base_damage.dart';
import 'package:remnant2_calculator/domain/effect.dart';

part 'item.freezed.dart';
part 'item.g.dart';

mixin _ItemField {
  String get name;

  List<Effect> get effects;

  bool get isDefault;
}

@freezed
class Item with _$Item, _ItemField {
  const Item._();

  const factory Item({
    required String name,
    @Default([]) List<Effect> effects,
    @Default(false) bool isDefault,
  }) = ItemData;

  const factory Item.weapon({
    required String name,
    required BaseDamage damage,
    @Default([]) List<Effect> effects,
    @Default(false) bool isDefault,
  }) = Weapon;

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
}
