import 'package:remnant2_calculator/domain/base_damage.dart';
import 'package:remnant2_calculator/domain/damage_type.dart';
import 'package:remnant2_calculator/domain/effect.dart';
import 'package:remnant2_calculator/domain/item.dart';

final itemMap = Map.fromEntries([
  ...archetypes,
  ...effectSkills,
  ...longGuns,
  ...handGuns,
  ...melees,
  ...mods,
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
      Effect.damageIncrease(40, damageTypes: [DamageType.range]),
      Effect.weakSpotDamage(15, damageTypes: [DamageType.range]),
      Effect.criticalChance(5, damageTypes: [DamageType.range]),
    ],
  ),
  Item(
    name: '槍手',
    effects: [
      Effect.damageIncrease(25, damageTypes: [DamageType.range]),
      Effect.criticalChance(5, damageTypes: [DamageType.range]),
    ],
  ),
  Item(
    name: '醫療兵',
    effects: [
      Effect.damageIncrease(25),
      Effect.criticalChance(5),
    ],
  ),
];

final effectSkills = [
  Item(
    name: '獵人1技能',
    effects: [
      Effect.damageIncrease(15, damageTypes: [DamageType.range]),
      Effect.criticalChance(15, damageTypes: [DamageType.range]),
    ],
  ),
];

final modifiers = [
  Item(
    name: '火熱射擊',
    effects: [
      Effect.damageIncrease(15, damageTypes: [DamageType.range]),
    ],
  ),
  Item(
    name: '腐蝕彈藥',
    effects: [
      Effect.criticalChance(15, damageTypes: [DamageType.range]),
    ],
  ),
];

final longGuns = [
  Weapon(
    name: '日暮',
    damage: const BaseDamage(93, [DamageType.range]),
    effects: [
      Effect.criticalChance(5),
      Effect.weakSpotDamage(105),
    ],
  ),
];

final handGuns = [
  Weapon(
    name: 'MP60-R',
    damage: const BaseDamage(27, [DamageType.range]),
    effects: [
      Effect.criticalChance(10),
      Effect.weakSpotDamage(100),
    ],
  ),
  Weapon(
    name: '奧秘',
    damage: const BaseDamage(42, [DamageType.range, DamageType.shock]),
    effects: [
      Effect.criticalChance(-10),
    ],
  ),
];

final melees = [
  Weapon(
    name: '科雷爾斧',
    damage: const BaseDamage(162, [DamageType.melee]),
    effects: [
      Effect.criticalChance(3),
      Effect.weakSpotDamage(85),
    ],
  ),
];

final mods = [
  const Weapon(
    name: '震顫',
    damage: BaseDamage(225, [DamageType.mod]),
    effects: [],
  ),
  const Weapon(
    name: '火焰風暴',
    damage: BaseDamage(225, [DamageType.fire, DamageType.mod]),
    effects: [],
  ),
];

final amulets = [
  Item(
    name: '腐蝕磨石',
    effects: [
      Effect.criticalChance(15),
      Effect.criticalDamage(30),
    ],
  ),
  Item(
    name: '聖十字輝光',
    effects: [
      Effect.damageIncrease(15),
    ],
  ),
];

final rings = [
  Item(
    name: '扎尼亞的惡意',
    effects: [
      Effect.weakSpotDamage(30),
    ],
  ),
  Item(
    name: '戰爭指環',
    effects: [
      Effect.criticalChance(15),
      Effect.criticalDamage(15),
    ],
  ),
  Item(
    name: '機率之圈',
    effects: [
      Effect.criticalDamage(30),
    ],
  ),
  Item(
    name: '破壞者之負擔',
    effects: [
      Effect.damageIncrease(15),
    ],
  ),
];

final relicFragments = [
  Item(
    name: '遠程傷害',
    effects: [
      Effect.damageIncrease(10, damageTypes: [DamageType.range]),
    ],
  ),
  Item(
    name: '遠程暴擊率',
    effects: [
      Effect.criticalChance(10, damageTypes: [DamageType.range]),
    ],
  ),
  Item(
    name: '遠程暴擊傷害',
    effects: [
      Effect.criticalDamage(20, damageTypes: [DamageType.range]),
    ],
  ),
];

final rangeMutators = [
  Item(
    name: '動量',
    effects: [
      Effect.criticalChance(30),
      Effect.criticalDamage(30),
    ],
  ),
  Item(
    name: '扭曲傷口',
    effects: [
      Effect.damageIncrease(20),
    ],
  ),
  Item(
    name: '調諧者',
    effects: [
      Effect.damageIncrease(20, damageTypes: [DamageType.mod]),
    ],
  ),
  Item(
    name: '失效保護',
    effects: [
      Effect.damageIncrease(20, damageTypes: [DamageType.mod]),
    ],
  ),
];
final meleeMutators = [
  Item(
    name: '污穢之刃',
    effects: [
      Effect.damageIncrease(20, damageTypes: [DamageType.melee]),
    ],
  ),
];
