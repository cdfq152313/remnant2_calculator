enum DamageType {
  range,
  melee,
  mod,
  fire,
  acid,
  shock,
  bow,
  explosion,
  skill,
}

extension DamageTypeExtension on DamageType {
  String get displayText => switch (this) {
        DamageType.range => '遠端',
        DamageType.melee => '近戰',
        DamageType.mod => '改裝',
        DamageType.fire => '火焰',
        DamageType.acid => '強酸',
        DamageType.shock => '電擊',
        DamageType.bow => '弓箭',
        DamageType.explosion => '爆炸',
        DamageType.skill => '技能',
      };
}

extension DamageTypeListExtension on List<DamageType> {
  String get displayText => isEmpty ? '無' : map((e) => e.displayText).join('/');
}
