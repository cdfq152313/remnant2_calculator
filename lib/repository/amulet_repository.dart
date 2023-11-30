import 'package:remnant2_calculator/repository/item_repository.dart';

class AmuletRepository extends ItemRepository {
  AmuletRepository(super._prefs, super.defaultJson);

  @override
  final String key = 'Amulet';
}
