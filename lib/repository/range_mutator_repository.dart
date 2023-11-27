import 'package:remnant2_calculator/data/item.dart';
import 'package:remnant2_calculator/domain/item.dart';
import 'package:remnant2_calculator/repository/regular_item_repository.dart';

class RangeMutatorRepository extends RegularItemRepository {
  RangeMutatorRepository(super._prefs);

  @override
  final String key = 'RangeMutator';

  @override
  List<Item> getDefaultItems() => rangeMutators;
}
