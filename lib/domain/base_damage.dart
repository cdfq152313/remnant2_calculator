import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:remnant2_calculator/domain/damage_type.dart';

part 'base_damage.freezed.dart';

part 'base_damage.g.dart';

@freezed
class BaseDamage with _$BaseDamage {
  const factory BaseDamage(
    double value, {
    required List<DamageType> damageTypes,
    double? rps,
  }) = _BaseDamage;

  factory BaseDamage.fromJson(Map<String, dynamic> json) =>
      _$BaseDamageFromJson(json);
}
