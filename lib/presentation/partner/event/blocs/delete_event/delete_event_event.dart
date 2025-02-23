part of 'delete_event_bloc.dart';

@freezed
class DeleteEventEvent with _$DeleteEventEvent {
  const factory DeleteEventEvent.started() = _Started;
  const factory DeleteEventEvent.deleteEvent(int id) = _DeleteEvent;
}
