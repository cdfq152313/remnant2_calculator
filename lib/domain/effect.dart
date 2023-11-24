enum DamageType { range, melee, mod, elemental, status }

sealed class Effect {
  Effect(
    this.value, {
    required this.damageTypes,
  });

  final int value;
  final List<DamageType> damageTypes;
}

class BaseDamage extends Effect {
  BaseDamage(super.value, {super.damageTypes = DamageType.values});
}

class DamageIncrease extends Effect {
  DamageIncrease(super.value, {super.damageTypes = DamageType.values});
}

class CriticalChance extends Effect {
  CriticalChance(super.value, {super.damageTypes = DamageType.values});
}

class CriticalDamage extends Effect {
  CriticalDamage(super.value, {super.damageTypes = DamageType.values});
}

class WeakSpotDamage extends Effect {
  WeakSpotDamage(super.value, {super.damageTypes = DamageType.values});
}
