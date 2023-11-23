class Calculation {
  Calculation({
    required this.baseDamage,
    required this.baseDamageIncrease,
    required this.criticalChance,
    required this.criticalDamage,
    required this.weakSpotDamage,
    required this.expectedDamage,
    required this.expectedWeakSpotDamage,
  });

  final int baseDamage;

  final int baseDamageIncrease;

  final int criticalChance;

  final int criticalDamage;

  final int weakSpotDamage;

  final int expectedDamage;

  final int expectedWeakSpotDamage;
}
