import 'package:remnant2_calculator/data/item.dart';
import 'package:remnant2_calculator/domain/item.dart';
import 'package:remnant2_calculator/repository/item_repository.dart';

class MeleeMutatorRepository extends ItemRepository {
  MeleeMutatorRepository(super._prefs);

  @override
  final String key = 'MeleeMutator';

  @override
  List<Item> getDefaultItems() => meleeMutators;
}
