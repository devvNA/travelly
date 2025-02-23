part of 'get_event_user_bloc.dart';

@freezed
class GetEventUserState with _$GetEventUserState {
  const factory GetEventUserState.initial() = _Initial;
  const factory GetEventUserState.loading() = _Loading;
  const factory GetEventUserState.success(EventResponseModel data) = _Success;
  const factory GetEventUserState.error(String message) = _Error;
}
