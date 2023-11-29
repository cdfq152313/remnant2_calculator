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
  String get displayText => isEmpty ? '無' : map((e) => e.displayText).join('/');
}