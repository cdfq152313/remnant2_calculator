import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:remnant2_calculator/domain/build_cubit.dart';
import 'package:remnant2_calculator/extension.dart';
import 'package:remnant2_calculator/repository/build_record_repository.dart';
import 'package:remnant2_calculator/util/auto_close.dart';

part 'build_record_cubit.freezed.dart';
part 'build_record_cubit.g.dart';

class BuildRecordCubit extends Cubit<List<BuildRecordState>> with AutoClose {
  BuildRecordCubit(this._repository) : super(_repository.getAll()) {
    subscriptions = [
      _repository.stream.listen((event) => emit(_repository.getAll()))
    ];
  }

  final BuildRecordRepository _repository;

  void editName(int index, String name) {
    emit(state.copyWithReplace(index, state[index].copyWith(name: name)));
  }

  void add(BuildState build) {
    _repository.add(BuildRecordState(build: build));
  }

  void removeAt(int index) {
    _repository.removeAt(index);
  }
}

@freezed
class BuildRecordState with _$BuildRecordState {
  const factory BuildRecordState({
    @Default('') String name,
    required BuildState build,
  }) = _BuildRecordState;

  factory BuildRecordState.fromJson(Map<String, dynamic> json) =>
      _$BuildRecordStateFromJson(json);
}
