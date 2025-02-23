part of 'create_event_bloc.dart';

@freezed
class CreateEventEvent with _$CreateEventEvent {
  const factory CreateEventEvent.started() = _Started;
  const factory CreateEventEvent.createEvent(CreateEventRequestModel model) =
      _CreateEvent;
}
