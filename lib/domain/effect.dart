import 'package:remnant2_calculator/domain/effect_merger.dart';

class Effect {
  static Map<Type, Effect> collect(List<Effect> effects) {
    final map = <Type, Effect>{};
    for (final effect in effects) {
      if (map.containsKey(effect.runtimeType)) {
        map[effect.runtimeType] = effect.merge(map[effect.runtimeType]);
      } else {
        map[effect.runtimeType] = effect;
      }
    }
    return map;
  }

  Effect(this.value, {this.merger = EffectMerger.sum});

  final int value;
  final EffectMerger merger;

  Effect merge(Effect? effect) => merger.merge(this, effect);
}

class BaseDamage extends Effect {
  BaseDamage(super.value);
}

class AllDamage extends Effect {
  AllDamage(super.value);
}

class AllCriticalChance extends Effect {
  AllCriticalChance(super.value) : super(merger: EffectMerger.sumLimit100);
}

class AllCriticalDamage extends Effect {
  AllCriticalDamage(super.value);
}

class AllWeakSpotDamage extends Effect {
  AllWeakSpotDamage(super.value);
}

class RangeDamage extends Effect {
  RangeDamage(super.value);
}

class RangeCriticalChance extends Effect {
  RangeCriticalChance(super.value) : super(merger: EffectMerger.sumLimit100);
}

class RangeCriticalDamage extends Effect {
  RangeCriticalDamage(super.value);
}

class RangeWeakSpotDamage extends Effect {
  RangeWeakSpotDamage(super.value);
}

class MeleeDamage extends Effect {
  MeleeDamage(super.value);
}

class MeleeCriticalChance extends Effect {
  MeleeCriticalChance(super.value) : super(merger: EffectMerger.sumLimit100);
}

class MeleeCriticalDamage extends Effect {
  MeleeCriticalDamage(super.value);
}

class MeleeWeakSpotDamage extends Effect {
  MeleeWeakSpotDamage(super.value);
}

class ModDamage extends Effect {
  ModDamage(super.value);
}

class ModCriticalChance extends Effect {
  ModCriticalChance(super.value) : super(merger: EffectMerger.sumLimit100);
}

class ModCriticalDamage extends Effect {
  ModCriticalDamage(super.value);
}

class ModWeakSpotDamage extends Effect {
  ModWeakSpotDamage(super.value);
}

class ElementalDamage extends Effect {
  ElementalDamage(super.value);
}

class ElementalCriticalChance extends Effect {
  ElementalCriticalChance(super.value)
      : super(merger: EffectMerger.sumLimit100);
}

class ElementalCriticalDamage extends Effect {
  ElementalCriticalDamage(super.value);
}
