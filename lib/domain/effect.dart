import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:remnant2_calculator/domain/damage_type.dart';

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

extension DamageTypeListExtension on List<DamageType> {
  String get displayText => map((e) => e.displayText).join('/');
}

@JsonSerializable()
class Effect {
  Effect({
    required this.type,
    required this.value,
    this.damageTypes = DamageType.values,
  });

  final int value;
  final EffectType type;
  final List<DamageType> damageTypes;

  String get _damageTypeText => damageTypes.length == DamageType.values.length
      ? '全部'
      : damageTypes.displayText;

  String get displayText => '$_damageTypeText${type.displayText} $value%';

  factory Effect.fromJson(Map<String, dynamic> json) => _$EffectFromJson(json);

  Map<String, dynamic> toJson() => _$EffectToJson(this);
}
