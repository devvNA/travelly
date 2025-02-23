part of 'delete_event_bloc.dart';

@freezed
class DeleteEventState with _$DeleteEventState {
  const factory DeleteEventState.initial() = _Initial;
  const factory DeleteEventState.loading() = _Loading;
  const factory DeleteEventState.success(String message) = _Success;
  const factory DeleteEventState.error(String message) = _Error;
}
