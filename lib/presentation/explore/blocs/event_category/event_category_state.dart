part of 'event_category_bloc.dart';

@freezed
class EventCategoryState with _$EventCategoryState {
  const factory EventCategoryState.initial() = _Initial;
  const factory EventCategoryState.loading() = _Loading;
  const factory EventCategoryState.success(EventCategoryResponseModel data) =
      _Success;
  const factory EventCategoryState.error(String message) = _Error;
}
