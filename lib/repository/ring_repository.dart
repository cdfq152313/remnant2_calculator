import 'package:remnant2_calculator/data/item.dart';
import 'package:remnant2_calculator/domain/item.dart';
import 'package:remnant2_calculator/repository/regular_item_repository.dart';

class RingRepository extends RegularItemRepository {
  RingRepository(super._prefs);

  @override
  final String key = 'Ring';

  @override
  List<Item> getDefaultItems() => rings;
}