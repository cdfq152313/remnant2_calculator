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

sealed class Effect {
  Effect(
    this.value, {
    required this.damageTypes,
  });

  final int value;
  final List<DamageType> damageTypes;

  String get _damageTypeText => damageTypes.length == DamageType.values.length
      ? '全部'
      : damageTypes.displayText;

  String get effectName => '';

  String get displayText => '$_damageTypeText$effectName $value%';
}

class DamageIncrease extends Effect {
  DamageIncrease(super.value, {super.damageTypes = DamageType.values});

  @override
  String get effectName => '傷害';
}

class CriticalChance extends Effect {
  CriticalChance(super.value, {super.damageTypes = DamageType.values});

  @override
  String get effectName => '暴擊率';
}

class CriticalDamage extends Effect {
  CriticalDamage(super.value, {super.damageTypes = DamageType.values});

  @override
  String get effectName => '暴擊傷害';
}

class WeakSpotDamage extends Effect {
  WeakSpotDamage(super.value, {super.damageTypes = DamageType.values});

  @override
  String get effectName => '弱點傷害';
}
