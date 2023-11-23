import 'package:remnant2_calculator/domain/effect.dart';
import 'package:remnant2_calculator/domain/item.dart';

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
