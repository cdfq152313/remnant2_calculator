enum DamageType {
  range,
  melee,
  mod,
  fire,
  acid,
  shock,
  bleeding,
  burning,
  corroded,
  overloaded,
  bow,
  explosion,
  skill,
  heavy,
}

extension DamageTypeExtension on DamageType {
  String get displayText => switch (this) {
        DamageType.range => '遠端',
        DamageType.melee => '近戰',
        DamageType.mod => '改裝',
        DamageType.fire => '火焰',
        DamageType.acid => '強酸',
        DamageType.shock => '電擊',
        DamageType.bleeding => '流血',
        DamageType.burning => '燃燒',
        DamageType.corroded => '腐蝕',
        DamageType.overloaded => '超載',
        DamageType.bow => '弓箭',
        DamageType.explosion => '爆炸',
        DamageType.skill => '技能',
        DamageType.heavy => '重型武器',
      };
}

extension DamageTypeListExtension on List<DamageType> {
  String get displayText => isEmpty ? '無' : map((e) => e.displayText).join('/');
}
