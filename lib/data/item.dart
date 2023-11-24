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
      AllDamage(40),
      AllWeakSpotDamage(15),
      AllCriticalChance(5),
    ],
  ),
  Item(
    name: '槍手',
    effects: [
      AllDamage(25),
      AllCriticalChance(5),
    ],
  ),
];

final modifiers = [
  Item(
    name: '獵人1技能',
    effects: [
      AllDamage(15),
      AllCriticalChance(15),
    ],
  ),
];

final weapon = [
  Item(
    name: '日暮',
    effects: [
      BaseDamage(100),
      AllCriticalChance(5),
    ],
  ),
];

final amulets = [
  Item(
    name: '腐蝕磨石',
    effects: [
      AllCriticalChance(15),
      AllCriticalDamage(30),
    ],
  ),
  Item(
    name: '聖十字輝光',
    effects: [
      BaseDamage(15),
    ],
  ),
];

final rings = [
  Item(
    name: '扎尼亞的惡意',
    effects: [
      AllWeakSpotDamage(30),
    ],
  ),
  Item(
    name: '戰爭指環',
    effects: [
      AllCriticalChance(15),
      AllCriticalDamage(15),
    ],
  ),
  Item(
    name: '機率之圈',
    effects: [
      AllCriticalDamage(30),
    ],
  ),
  Item(
    name: '破壞者之負擔',
    effects: [
      AllDamage(15),
    ],
  ),
];

final relicFragments = [
  Item(
    name: '遠程傷害',
    effects: [
      AllDamage(10),
    ],
  ),
  Item(
    name: '遠程暴擊率',
    effects: [
      AllCriticalChance(10),
    ],
  ),
  Item(
    name: '遠程暴擊傷害',
    effects: [
      AllCriticalDamage(20),
    ],
  ),
];

final mutator = [
  Item(
    name: '動量',
    effects: [
      AllCriticalChance(30),
      AllCriticalDamage(30),
    ],
  ),
];
