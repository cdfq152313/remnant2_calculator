import 'package:remnant2_calculator/domain/item.dart';
import 'package:remnant2_calculator/repository/item_repository.dart';

abstract class RegularItemRepository extends ItemRepository<Item> {
  RegularItemRepository(super.prefs);

  @override
  Item fromJson(Map<String, dynamic> json) {
    return Item.fromJson(json);
  }
}
