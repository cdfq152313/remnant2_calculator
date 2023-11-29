import 'package:bloc/bloc.dart';
import 'package:remnant2_calculator/domain/build_cubit.dart';

class SelectBuildCubit extends Cubit<BuildState?> {
  SelectBuildCubit(super.initialState);

  void select(BuildState? state) {
    emit(state);
  }
}
