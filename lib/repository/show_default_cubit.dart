import 'package:bloc/bloc.dart';

class ShowDefaultCubit extends Cubit<bool> {
  ShowDefaultCubit(super.initialState);

  void toggle() {
    emit(!state);
  }

  void set(bool value) {
    emit(value);
  }
}
