import 'package:remnant2_calculator/domain/item.dart';
import 'package:remnant2_calculator/repository/repository_pack.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';

void main() {
  test('Check import / export', () async {
    const item = Item(name: 'hello');

    SharedPreferences.setMockInitialValues({});
    var prefs = await SharedPreferences.getInstance();
    var pack = RepositoryPack(prefs, {});
    pack.archetypeRepository.add(item);
    final exportValue = pack.export();

    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    pack = RepositoryPack(prefs, {});
    pack.import(exportValue);

    expect(pack.archetypeRepository.getAllCustomized().first, equals(item));
  });
}
