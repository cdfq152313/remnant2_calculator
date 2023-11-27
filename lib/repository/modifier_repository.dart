import 'package:remnant2_calculator/data/item.dart';
import 'package:remnant2_calculator/domain/item.dart';
import 'package:remnant2_calculator/repository/regular_item_repository.dart';

class ModifierRepository extends RegularItemRepository {
  ModifierRepository(super._prefs);

  @override
  final String key = 'Modifier';

  @override
  List<Item> getDefaultItems() => modifiers;
}
