part of 'get_skus_bloc.dart';

@freezed
class GetSkusEvent with _$GetSkusEvent {
  const factory GetSkusEvent.started() = _Started;
  const factory GetSkusEvent.getSkus() = _GetSkus;
}
