import 'package:remnant2_calculator/repository/item_repository.dart';

class ModifierRepository extends ItemRepository {
  ModifierRepository(super._prefs, super.defaultJson);

  @override
  final String key = 'Modifier';
}
