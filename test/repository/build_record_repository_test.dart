import 'package:remnant2_calculator/domain/build_cubit.dart';
import 'package:remnant2_calculator/domain/build_record_cubit.dart';
import 'package:remnant2_calculator/repository/build_record_repository.dart';
import 'package:remnant2_calculator/repository/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';

void main() {
  test('Add instance to repository successfully. Also trigger update event.',
      () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final item = BuildRecordState(build: BuildState());
    var repository = BuildRecordRepository(prefs);
    final event = repository.stream.first;

    repository.add(item);
    repository = BuildRecordRepository(prefs);

    expect(await event, isA<Update>());
    expect(repository.getAll().first, equals(item));
  });
}
