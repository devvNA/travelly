part of 'create_event_bloc.dart';

@freezed
class CreateEventState with _$CreateEventState {
  const factory CreateEventState.initial() = _Initial;
  const factory CreateEventState.loading() = _Loading;
  const factory CreateEventState.success(String message) = _Success;
  const factory CreateEventState.error(String message) = _Error;
}
