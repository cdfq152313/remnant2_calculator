import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:remnant2_calculator/domain/damage_type.dart';

part 'effect.freezed.dart';
part 'effect.g.dart';

enum EffectType {
  damageIncrease,
  criticalChance,
  criticalDamage,
  weakSpotDamage,
}

extension EffectTypeExtension on EffectType {
  String get displayText => switch (this) {
        EffectType.damageIncrease => '傷害',
        EffectType.criticalChance => '暴擊率',
        EffectType.criticalDamage => '暴擊傷害',
        EffectType.weakSpotDamage => '弱點傷害',
      };
}

@freezed
class Effect with _$Effect {
  const Effect._();

  const factory Effect({
    required EffectType type,
    required double value,
    @Default(DamageType.values) List<DamageType> damageTypes,
  }) = _Effect;

  factory Effect.damageIncrease(
    double value, {
    List<DamageType> damageTypes = DamageType.values,
  }) =>
      _Effect(
        type: EffectType.damageIncrease,
        damageTypes: damageTypes,
        value: value,
      );

  factory Effect.criticalChance(
    double value, {
    List<DamageType> damageTypes = DamageType.values,
  }) =>
      _Effect(
        type: EffectType.criticalChance,
        damageTypes: damageTypes,
        value: value,
      );

  factory Effect.criticalDamage(
    double value, {
    List<DamageType> damageTypes = DamageType.values,
  }) =>
      _Effect(
        type: EffectType.criticalDamage,
        damageTypes: damageTypes,
        value: value,
      );

  factory Effect.weakSpotDamage(
    double value, {
    List<DamageType> damageTypes = DamageType.values,
  }) =>
      _Effect(
        type: EffectType.weakSpotDamage,
        damageTypes: damageTypes,
        value: value,
      );

  factory Effect.fromJson(Map<String, dynamic> json) => _$EffectFromJson(json);

  String get _damageTypeText => damageTypes.length == DamageType.values.length
      ? '全部'
      : damageTypes.displayText;

  String get displayText => '$_damageTypeText${type.displayText} $value%';
}
