part of 'edit_event_bloc.dart';

@freezed
class EditEventState with _$EditEventState {
  const factory EditEventState.initial() = _Initial;
  const factory EditEventState.loading() = _Loading;
  const factory EditEventState.success(String message) = _Success;
  const factory EditEventState.error(String message) = _Error;
}
