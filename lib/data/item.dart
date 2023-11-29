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
  const Item(
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
  const Item(
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
  const Item(
    name: '醫療兵',
    effects: [
      Effect(type: EffectType.damageIncrease, value: 25),
      Effect(type: EffectType.criticalChance, value: 5),
    ],
  ),
];

final modifiers = [
  const Item(
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
  const Weapon(
    name: '日暮',
    damage: BaseDamage(93, [DamageType.range]),
    effects: [
      Effect(type: EffectType.criticalChance, value: 5),
      Effect(type: EffectType.weakSpotDamage, value: 105),
    ],
  ),
];

final handGuns = [
  const Weapon(
    name: 'MP60-R',
    damage: BaseDamage(27, [DamageType.range]),
    effects: [
      Effect(type: EffectType.criticalChance, value: 10),
      Effect(type: EffectType.weakSpotDamage, value: 100),
    ],
  ),
];

final melees = [
  const Weapon(
    name: '科雷爾斧',
    damage: BaseDamage(162, [DamageType.melee]),
    effects: [
      Effect(type: EffectType.criticalChance, value: 3),
      Effect(type: EffectType.weakSpotDamage, value: 85),
    ],
  ),
];

final amulets = [
  const Item(
    name: '腐蝕磨石',
    effects: [
      Effect(type: EffectType.criticalChance, value: 15),
      Effect(type: EffectType.criticalDamage, value: 30),
    ],
  ),
  const Item(
    name: '聖十字輝光',
    effects: [
      Effect(type: EffectType.damageIncrease, value: 15),
    ],
  ),
];

final rings = [
  const Item(
    name: '扎尼亞的惡意',
    effects: [
      Effect(type: EffectType.weakSpotDamage, value: 30),
    ],
  ),
  const Item(
    name: '戰爭指環',
    effects: [
      Effect(type: EffectType.criticalChance, value: 15),
      Effect(type: EffectType.criticalDamage, value: 15),
    ],
  ),
  const Item(
    name: '機率之圈',
    effects: [
      Effect(type: EffectType.criticalDamage, value: 30),
    ],
  ),
  const Item(
    name: '破壞者之負擔',
    effects: [
      Effect(type: EffectType.damageIncrease, value: 15),
    ],
  ),
];

final relicFragments = [
  const Item(
    name: '遠程傷害',
    effects: [
      Effect(
        type: EffectType.damageIncrease,
        value: 10,
        damageTypes: [DamageType.range],
      ),
    ],
  ),
  const Item(
    name: '遠程暴擊率',
    effects: [
      Effect(
        type: EffectType.criticalChance,
        value: 10,
        damageTypes: [DamageType.range],
      ),
    ],
  ),
  const Item(
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
  const Item(
    name: '動量',
    effects: [
      Effect(type: EffectType.criticalChance, value: 30),
      Effect(type: EffectType.criticalDamage, value: 30),
    ],
  ),
  const Item(
    name: '扭曲傷口',
    effects: [
      Effect(type: EffectType.damageIncrease, value: 20),
    ],
  ),
  const Item(
    name: '調諧者',
    effects: [
      Effect(
        type: EffectType.damageIncrease,
        value: 20,
        damageTypes: [DamageType.mod],
      ),
    ],
  ),
  const Item(
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
  const Item(
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
