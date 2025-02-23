part of 'get_event_user_bloc.dart';

@freezed
class GetEventUserEvent with _$GetEventUserEvent {
  const factory GetEventUserEvent.started() = _Started;
  const factory GetEventUserEvent.getEventUser() = _GetEventUser;
}
