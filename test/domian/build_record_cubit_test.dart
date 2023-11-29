import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remnant2_calculator/data/item.dart';
import 'package:remnant2_calculator/domain/build_cubit.dart';
import 'package:remnant2_calculator/domain/build_record_cubit.dart';
import 'package:remnant2_calculator/repository/build_record_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late BuildRecordRepository repository;
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    repository = BuildRecordRepository(prefs);
  });

  blocTest(
    'Add build successfully',
    build: () => BuildRecordCubit(repository),
    act: (cubit) => cubit.add(BuildState(primaryArchetype: itemMap['獵人'])),
    expect: () => [
      [BuildRecordState(build: BuildState(primaryArchetype: itemMap['獵人']))],
    ],
  );
}
