import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'keyword_and_show_default_cubit.freezed.dart';

class KeywordAndShowDefaultCubit extends Cubit<KeywordAndShowDefaultState> {
  KeywordAndShowDefaultCubit() : super(const KeywordAndShowDefaultState());

  void setShowDefault(bool value) {
    emit(state.copyWith(showDefault: value));
  }

  void setKeyword(String keyword) {
    emit(state.copyWith(keyword: keyword));
  }
}

@freezed
@freezed
class KeywordAndShowDefaultState with _$KeywordAndShowDefaultState {
  const factory KeywordAndShowDefaultState({
    @Default(true) bool showDefault,
    @Default('') String keyword,
  }) = _KeywordAndShowDefaultState;
}
