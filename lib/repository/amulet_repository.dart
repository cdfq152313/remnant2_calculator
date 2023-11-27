import 'package:remnant2_calculator/data/item.dart';
import 'package:remnant2_calculator/domain/item.dart';
import 'package:remnant2_calculator/repository/item_repository.dart';

class AmuletRepository extends ItemRepository {
  AmuletRepository(super._prefs);

  @override
  final String key = 'Amulet';

  @override
  List<Item> getDefaultItems() => amulets;
}
