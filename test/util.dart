import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_test/flutter_test.dart';
import 'package:remnant2_calculator/domain/item.dart';
import 'package:remnant2_calculator/repository/item_repository.dart';
import 'package:remnant2_calculator/repository/repository_pack.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Map<String, Item>> getItemMap() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  SharedPreferences.setMockInitialValues({});
  final pack = RepositoryPack(
    await SharedPreferences.getInstance(),
    jsonDecode(await rootBundle.loadString('assets/default_item.json')),
  );

  return {
    for (final repository in pack.repositories.whereType<ItemRepository>())
      for (final item in repository.getAll()) item.name: item,
  };
}
