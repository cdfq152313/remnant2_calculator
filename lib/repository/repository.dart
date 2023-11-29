import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Update {}

abstract class Repository<T> {
  Repository(this._prefs);

  final SharedPreferences _prefs;

  String get key;

  final StreamController<Update> _controller = StreamController.broadcast();

  Stream<Update> get stream => _controller.stream;

  T fromJson(Map<String, dynamic> json);

  void saveToDb(List<T> items) {
    _controller.sink.add(Update());
    _prefs.setString(key, jsonEncode(items));
  }

  List<T> loadFromDb() {
    final json = jsonDecode(_prefs.getString(key) ?? '[]') as List;
    return json.map((json) => fromJson(json)).toList();
  }
}
