import 'dart:math';

import 'package:remnant2_calculator/domain/effect.dart';

abstract class EffectMerger {
  const EffectMerger();

  static const EffectMerger sum = _SumMerger();
  static const EffectMerger sumLimit100 = _SumLimit100Merger();

  Effect merge(Effect? effect1, Effect? effect2);
}

class _SumMerger extends EffectMerger {
  const _SumMerger();

  @override
  Effect merge(Effect? effect1, Effect? effect2) {
    return switch ((effect1, effect2)) {
      (null, null) => Effect(0),
      (Effect effect, null) || (null, Effect effect) => effect,
      (Effect effect1, Effect effect2) =>
        Effect(effect1.value + effect2.value, merger: this),
    };
  }
}

class _SumLimit100Merger extends EffectMerger {
  const _SumLimit100Merger();

  @override
  Effect merge(Effect? effect1, Effect? effect2) {
    return switch ((effect1, effect2)) {
      (null, null) => Effect(0),
      (Effect effect, null) || (null, Effect effect) => effect,
      (Effect effect1, Effect effect2) => Effect(
          min(effect1.value + effect2.value, 100),
          merger: this,
        ),
    };
  }
}
