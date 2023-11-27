import 'package:remnant2_calculator/data/item.dart';
import 'package:remnant2_calculator/domain/item.dart';
import 'package:remnant2_calculator/repository/item_repository.dart';

class RangeMutatorRepository extends ItemRepository {
  RangeMutatorRepository(super._prefs);

  @override
  final String key = 'RangeMutator';

  @override
  List<Item> getDefaultItems() => rangeMutators;
}
