import 'package:remnant2_calculator/data/item.dart';
import 'package:remnant2_calculator/domain/item.dart';
import 'package:remnant2_calculator/repository/item_repository.dart';

class RelicFragmentRepository extends ItemRepository {
  RelicFragmentRepository(super._prefs);

  @override
  final String key = 'RelicFragment';

  @override
  List<Item> getDefaultItems() => relicFragments;
}
