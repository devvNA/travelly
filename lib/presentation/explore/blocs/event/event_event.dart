part of 'event_bloc.dart';

@freezed
class EventEvent with _$EventEvent {
  const factory EventEvent.started() = _Started;
  const factory EventEvent.getEvents() = _GetEvents;
  const factory EventEvent.searchEvent(String query) = _SearchEvent;
  const factory EventEvent.getEventsByCategory(String category) =
      _GetEventsByCategory;
  const factory EventEvent.fetchAllFromState() = _FetchAllFromState;
}
