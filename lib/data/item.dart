import 'package:remnant2_calculator/domain/base_damage.dart';
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
      DamageIncrease(40, damageTypes: [DamageType.range]),
      WeakSpotDamage(15, damageTypes: [DamageType.range]),
      CriticalChance(5, damageTypes: [DamageType.range]),
    ],
  ),
  const Item(
    name: '槍手',
    effects: [
      DamageIncrease(25, damageTypes: [DamageType.range]),
      CriticalChance(5, damageTypes: [DamageType.range]),
    ],
  ),
  const Item(
    name: '醫療兵',
    effects: [
      DamageIncrease(25),
      CriticalChance(5),
    ],
  ),
];

final modifiers = [
  const Item(
    name: '獵人1技能',
    effects: [
      DamageIncrease(15, damageTypes: [DamageType.range]),
      CriticalChance(15, damageTypes: [DamageType.range]),
    ],
  ),
];

final longGuns = [
  const Weapon(
    name: '日暮',
    damage: BaseDamage(93, [DamageType.range]),
    effects: [
      CriticalChance(5),
      WeakSpotDamage(105),
    ],
  ),
];

final handGuns = [
  const Weapon(
    name: 'MP60-R',
    damage: BaseDamage(27, [DamageType.range]),
    effects: [
      CriticalChance(10),
      WeakSpotDamage(100),
    ],
  ),
];

final melees = [
  const Weapon(
    name: '斧頭',
    damage: BaseDamage(162, [DamageType.melee]),
    effects: [
      CriticalChance(3),
      WeakSpotDamage(85),
    ],
  ),
];

final amulets = [
  const Item(
    name: '腐蝕磨石',
    effects: [
      CriticalChance(15),
      CriticalDamage(30),
    ],
  ),
  const Item(
    name: '聖十字輝光',
    effects: [
      DamageIncrease(15),
    ],
  ),
];

final rings = [
  const Item(
    name: '扎尼亞的惡意',
    effects: [
      WeakSpotDamage(30),
    ],
  ),
  const Item(
    name: '戰爭指環',
    effects: [
      CriticalChance(15),
      CriticalDamage(15),
    ],
  ),
  const Item(
    name: '機率之圈',
    effects: [
      CriticalDamage(30),
    ],
  ),
  const Item(
    name: '破壞者之負擔',
    effects: [
      DamageIncrease(15),
    ],
  ),
];

final relicFragments = [
  const Item(
    name: '遠程傷害',
    effects: [
      DamageIncrease(10, damageTypes: [DamageType.range]),
    ],
  ),
  const Item(
    name: '遠程暴擊率',
    effects: [
      CriticalChance(10, damageTypes: [DamageType.range]),
    ],
  ),
  const Item(
    name: '遠程暴擊傷害',
    effects: [
      CriticalDamage(20, damageTypes: [DamageType.range]),
    ],
  ),
];

final rangeMutators = [
  const Item(
    name: '動量',
    effects: [
      CriticalChance(30),
      CriticalDamage(30),
    ],
  ),
  const Item(
    name: '扭曲傷口',
    effects: [
      DamageIncrease(20),
    ],
  ),
  const Item(
    name: '調諧者',
    effects: [
      DamageIncrease(20, damageTypes: [DamageType.mod]),
    ],
  ),
  const Item(
    name: '失效保護',
    effects: [
      DamageIncrease(20, damageTypes: [DamageType.mod]),
    ],
  ),
];
final meleeMutators = [
  const Item(
    name: '污穢之刃',
    effects: [
      DamageIncrease(20),
    ],
  ),
];
