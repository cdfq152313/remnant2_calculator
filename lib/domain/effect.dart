class Effect {
  Effect(this.value);

  final int value;

  Effect merge(Effect effect) {
    return Effect(value + effect.value);
  }
}

class BaseDamage extends Effect {
  BaseDamage(super.value);
}

class AllDamage extends Effect {
  AllDamage(super.value);
}

class AllCriticalChance extends Effect {
  AllCriticalChance(super.value);
}

class AllCriticalDamage extends Effect {
  AllCriticalDamage(super.value);
}

class AllWeakSpotDamage extends Effect {
  AllWeakSpotDamage(super.value);
}
