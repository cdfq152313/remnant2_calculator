import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:remnant2_calculator/domain/damage_type.dart';

part 'base_damage.g.dart';

@JsonSerializable()
class BaseDamage {
  BaseDamage(this.value, this.damageTypes);

  final int value;
  final List<DamageType> damageTypes;

  factory BaseDamage.fromJson(Map<String, dynamic> json) =>
      _$BaseDamageFromJson(json);

  Map<String, dynamic> toJson() => _$BaseDamageToJson(this);
}
