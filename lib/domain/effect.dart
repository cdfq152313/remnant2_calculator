import 'dart:math';

class Effect {
  static Map<Type, Effect> collect(List<Effect> effects) {
    final map = <Type, Effect>{};
    for (final effect in effects) {
      if (map.containsKey(effect.runtimeType)) {
        map[effect.runtimeType] = effect.merge(map[effect.runtimeType]!);
      } else {
        map[effect.runtimeType] = effect;
      }
    }
    return map;
  }

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

  @override
  Effect merge(Effect effect) {
    return Effect(min(100, value + effect.value));
  }
}

class AllCriticalDamage extends Effect {
  AllCriticalDamage(super.value);
}

class AllWeakSpotDamage extends Effect {
  AllWeakSpotDamage(super.value);
}
