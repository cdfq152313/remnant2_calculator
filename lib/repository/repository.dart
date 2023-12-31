import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Update {}

abstract class Repository<T> {
  Repository(this._prefs);

  final SharedPreferences _prefs;

  @protected
  String get key;

  final StreamController<Update> _controller = StreamController.broadcast();

  Stream<Update> get stream => _controller.stream;

  @protected
  T fromJson(Map<String, dynamic> json);

  List<T> export();

  List<T> deserialize(List data) {
    return data.map((e) => fromJson(e)).toList();
  }

  void import(List data) {
    onImport(deserialize(data));
  }

  @protected
  void onImport(List<T> data);

  @protected
  void saveToDb(List<T> items) {
    _controller.sink.add(Update());
    _prefs.setString(key, jsonEncode(items));
  }

  @protected
  List<T> loadFromDb() {
    final json = jsonDecode(_prefs.getString(key) ?? '[]') as List;
    return json.map((json) => fromJson(json)).toList();
  }
}
