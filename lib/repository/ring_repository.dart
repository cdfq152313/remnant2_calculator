import 'package:remnant2_calculator/repository/item_repository.dart';

class RingRepository extends ItemRepository {
  RingRepository(super._prefs, super.defaultJson);

  @override
  final String key = 'Ring';
}
