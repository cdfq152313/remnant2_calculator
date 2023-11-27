import 'package:remnant2_calculator/domain/base_damage.dart';
import 'package:remnant2_calculator/domain/damage_type.dart';
import 'package:remnant2_calculator/domain/effect.dart';
import 'package:remnant2_calculator/domain/item.dart';

final itemMap = Map.fromEntries([
  ...archetypes,
  ...longGuns,
  ...handGuns,
  ...melees,
  ...amulets,
  ...rings,
  ...relicFragments,
  ...rangeMutators,
  ...meleeMutators,
  ...modifiers,
].map((v) => MapEntry(v.name, v)));

final archetypes = [
  Item(
    name: '獵人',
    effects: [
      Effect(
        type: EffectType.damageIncrease,
        value: 40,
        damageTypes: [DamageType.range],
      ),
      Effect(
        type: EffectType.weakSpotDamage,
        value: 15,
        damageTypes: [DamageType.range],
      ),
      Effect(
        type: EffectType.criticalChance,
        value: 5,
        damageTypes: [DamageType.range],
      ),
    ],
  ),
  Item(
    name: '槍手',
    effects: [
      Effect(
        type: EffectType.damageIncrease,
        value: 25,
        damageTypes: [DamageType.range],
      ),
      Effect(
        type: EffectType.criticalChance,
        value: 5,
        damageTypes: [DamageType.range],
      ),
    ],
  ),
  Item(
    name: '醫療兵',
    effects: [
      Effect(type: EffectType.damageIncrease, value: 25),
      Effect(type: EffectType.criticalChance, value: 5),
    ],
  ),
];

final modifiers = [
  Item(
    name: '獵人1技能',
    effects: [
      Effect(
        type: EffectType.damageIncrease,
        value: 15,
        damageTypes: [DamageType.range],
      ),
      Effect(
        type: EffectType.criticalChance,
        value: 15,
        damageTypes: [DamageType.range],
      ),
    ],
  ),
];

final longGuns = [
  Weapon(
    name: '日暮',
    damage: BaseDamage(93, [DamageType.range]),
    effects: [
      Effect(type: EffectType.criticalChance, value: 5),
      Effect(type: EffectType.weakSpotDamage, value: 105),
    ],
  ),
];

final handGuns = [
  Weapon(
    name: 'MP60-R',
    damage: BaseDamage(27, [DamageType.range]),
    effects: [
      Effect(type: EffectType.criticalChance, value: 10),
      Effect(type: EffectType.weakSpotDamage, value: 100),
    ],
  ),
];

final melees = [
  Weapon(
    name: '斧頭',
    damage: BaseDamage(162, [DamageType.melee]),
    effects: [
      Effect(type: EffectType.criticalChance, value: 3),
      Effect(type: EffectType.weakSpotDamage, value: 85),
    ],
  ),
];

final amulets = [
  Item(
    name: '腐蝕磨石',
    effects: [
      Effect(type: EffectType.criticalChance, value: 15),
      Effect(type: EffectType.criticalDamage, value: 30),
    ],
  ),
  Item(
    name: '聖十字輝光',
    effects: [
      Effect(type: EffectType.damageIncrease, value: 15),
    ],
  ),
];

final rings = [
  Item(
    name: '扎尼亞的惡意',
    effects: [
      Effect(type: EffectType.weakSpotDamage, value: 30),
    ],
  ),
  Item(
    name: '戰爭指環',
    effects: [
      Effect(type: EffectType.criticalChance, value: 15),
      Effect(type: EffectType.criticalDamage, value: 15),
    ],
  ),
  Item(
    name: '機率之圈',
    effects: [
      Effect(type: EffectType.criticalDamage, value: 30),
    ],
  ),
  Item(
    name: '破壞者之負擔',
    effects: [
      Effect(type: EffectType.damageIncrease, value: 15),
    ],
  ),
];

final relicFragments = [
  Item(
    name: '遠程傷害',
    effects: [
      Effect(
        type: EffectType.damageIncrease,
        value: 10,
        damageTypes: [DamageType.range],
      ),
    ],
  ),
  Item(
    name: '遠程暴擊率',
    effects: [
      Effect(
        type: EffectType.criticalChance,
        value: 10,
        damageTypes: [DamageType.range],
      ),
    ],
  ),
  Item(
    name: '遠程暴擊傷害',
    effects: [
      Effect(
        type: EffectType.criticalDamage,
        value: 20,
        damageTypes: [DamageType.range],
      ),
    ],
  ),
];

final rangeMutators = [
  Item(
    name: '動量',
    effects: [
      Effect(type: EffectType.criticalChance, value: 30),
      Effect(type: EffectType.criticalDamage, value: 30),
    ],
  ),
  Item(
    name: '扭曲傷口',
    effects: [
      Effect(type: EffectType.damageIncrease, value: 20),
    ],
  ),
  Item(
    name: '調諧者',
    effects: [
      Effect(
        type: EffectType.damageIncrease,
        value: 20,
        damageTypes: [DamageType.mod],
      ),
    ],
  ),
  Item(
    name: '失效保護',
    effects: [
      Effect(
        type: EffectType.damageIncrease,
        value: 20,
        damageTypes: [DamageType.mod],
      ),
    ],
  ),
];
final meleeMutators = [
  Item(
    name: '污穢之刃',
    effects: [
      Effect(
        type: EffectType.damageIncrease,
        value: 20,
        damageTypes: [DamageType.melee],
      ),
    ],
  ),
];
