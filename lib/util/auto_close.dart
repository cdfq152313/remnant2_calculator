import 'dart:async';

import 'package:bloc/bloc.dart';

mixin AutoClose<T> on Cubit<T> {
  List<StreamSubscription> subscriptions = [];

  @override
  Future<void> close() {
    for (final subscription in subscriptions) {
      subscription.cancel();
    }
    return super.close();
  }
}
