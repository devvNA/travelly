part of 'edit_event_bloc.dart';

@freezed
class EditEventEvent with _$EditEventEvent {
  const factory EditEventEvent.started() = _Started;
  const factory EditEventEvent.edit(CreateEventRequestModel model, int id) =
      _EditEvent;
}
