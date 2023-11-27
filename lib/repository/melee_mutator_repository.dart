import 'package:remnant2_calculator/data/item.dart';
import 'package:remnant2_calculator/domain/item.dart';
import 'package:remnant2_calculator/repository/regular_item_repository.dart';

class MeleeMutatorRepository extends RegularItemRepository {
  MeleeMutatorRepository(super._prefs);

  @override
  final String key = 'MeleeMutator';

  @override
  List<Item> getDefaultItems() => meleeMutators;
}
