part of 'event_bloc.dart';

@freezed
class EventState with _$EventState {
  const factory EventState.initial() = _Initial;
  const factory EventState.loading() = _Loading;
  const factory EventState.success(List<EventModel> events) = _Success;
  const factory EventState.error(String message) = _Error;
}
