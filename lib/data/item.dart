import 'package:remnant2_calculator/domain/effect.dart';
import 'package:remnant2_calculator/domain/item.dart';

final itemMap = Map.fromEntries([
  ...archetypes,
  ...weapon,
  ...amulets,
  ...rings,
  ...relicFragments,
  ...mutator,
  ...modifiers,
].map((v) => MapEntry(v.name, v)));

final archetypes = [
  Item(
    name: '獵人',
    effects: [
      DamageIncrease(40, damageTypes: [DamageType.range]),
      WeakSpotDamage(15, damageTypes: [DamageType.range]),
      CriticalChance(5, damageTypes: [DamageType.range]),
    ],
  ),
  Item(
    name: '槍手',
    effects: [
      DamageIncrease(25, damageTypes: [DamageType.range]),
      CriticalChance(5, damageTypes: [DamageType.range]),
    ],
  ),
];

final modifiers = [
  Item(
    name: '獵人1技能',
    effects: [
      DamageIncrease(15, damageTypes: [DamageType.range]),
      CriticalChance(15, damageTypes: [DamageType.range]),
    ],
  ),
];

final weapon = [
  Weapon(
    name: '日暮',
    damageTypes: [DamageType.range],
    effects: [
      BaseDamage(100),
      CriticalChance(5),
      WeakSpotDamage(105),
    ],
  ),
];

final amulets = [
  Item(
    name: '腐蝕磨石',
    effects: [
      CriticalChance(15),
      CriticalDamage(30),
    ],
  ),
  Item(
    name: '聖十字輝光',
    effects: [
      DamageIncrease(15),
    ],
  ),
];

final rings = [
  Item(
    name: '扎尼亞的惡意',
    effects: [
      WeakSpotDamage(30),
    ],
  ),
  Item(
    name: '戰爭指環',
    effects: [
      CriticalChance(15),
      CriticalDamage(15),
    ],
  ),
  Item(
    name: '機率之圈',
    effects: [
      CriticalDamage(30),
    ],
  ),
  Item(
    name: '破壞者之負擔',
    effects: [
      DamageIncrease(15),
    ],
  ),
];

final relicFragments = [
  Item(
    name: '遠程傷害',
    effects: [
      DamageIncrease(10, damageTypes: [DamageType.range]),
    ],
  ),
  Item(
    name: '遠程暴擊率',
    effects: [
      CriticalChance(10, damageTypes: [DamageType.range]),
    ],
  ),
  Item(
    name: '遠程暴擊傷害',
    effects: [
      CriticalDamage(20, damageTypes: [DamageType.range]),
    ],
  ),
];

final mutator = [
  Item(
    name: '動量',
    effects: [
      CriticalChance(30),
      CriticalDamage(30),
    ],
  ),
];
