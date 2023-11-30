import 'package:remnant2_calculator/data/item.dart';
import 'package:remnant2_calculator/domain/item.dart';
import 'package:remnant2_calculator/repository/item_repository.dart';

class EffectSkillRepository extends ItemRepository {
  EffectSkillRepository(super._prefs);

  @override
  final String key = 'EffectSkill';

  @override
  List<Item> getDefaultItems() => effectSkills;
}
