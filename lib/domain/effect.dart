import 'package:freezed_annotation/freezed_annotation.dart';

part 'effect.freezed.dart';

part 'effect.g.dart';

enum DamageType { range, melee, mod, elemental, status }

extension DamageTypeExtension on DamageType {
  String get displayText => switch (this) {
        DamageType.range => '遠端',
        DamageType.melee => '近戰',
        DamageType.mod => '改裝',
        DamageType.elemental => '元素',
        DamageType.status => '狀態',
      };
}

extension DamageTypeListExtension on List<DamageType> {
  String get displayText => map((e) => e.displayText).join('/');
}

mixin _EffectField {
  int get value;

  List<DamageType> get damageTypes;
}

@freezed
sealed class Effect with _$Effect, _EffectField {
  const Effect._();

  const factory Effect.damageIncrease(
    int value, {
    @Default(DamageType.values) List<DamageType> damageTypes,
  }) = DamageIncrease;

  const factory Effect.criticalChance(
    int value, {
    @Default(DamageType.values) List<DamageType> damageTypes,
  }) = CriticalChance;

  const factory Effect.criticalDamage(
    int value, {
    @Default(DamageType.values) List<DamageType> damageTypes,
  }) = CriticalDamage;

  const factory Effect.weakSpotDamage(
    int value, {
    @Default(DamageType.values) List<DamageType> damageTypes,
  }) = WeakSpotDamage;

  factory Effect.fromJson(Map<String, dynamic> json) => _$EffectFromJson(json);

  String get _damageTypeText => damageTypes.length == DamageType.values.length
      ? '全部'
      : damageTypes.displayText;

  String get effectName => switch (this) {
        DamageIncrease() => '傷害',
        CriticalChance() => '暴擊率',
        CriticalDamage() => '暴擊傷害',
        WeakSpotDamage() => '弱點傷害',
      };

  Type get caseType => switch (this) {
        DamageIncrease() => DamageIncrease,
        CriticalChance() => CriticalChance,
        CriticalDamage() => CriticalDamage,
        WeakSpotDamage() => WeakSpotDamage,
      };

  String get displayText => '$_damageTypeText$effectName $value%';
}
