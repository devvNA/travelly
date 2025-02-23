part of 'event_category_bloc.dart';

@freezed
class EventCategoryEvent with _$EventCategoryEvent {
  const factory EventCategoryEvent.started() = _Started;
  const factory EventCategoryEvent.getEventCategories() = _GetEventCategories;
}
