import 'package:remnant2_calculator/repository/item_repository.dart';

class RelicFragmentRepository extends ItemRepository {
  RelicFragmentRepository(super._prefs, super.defaultJson);

  @override
  final String key = 'RelicFragment';
}
