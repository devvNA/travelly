part of 'get_skus_bloc.dart';

@freezed
class GetSkusState with _$GetSkusState {
  const factory GetSkusState.initial() = _Initial;
  const factory GetSkusState.loading() = _Loading;
  const factory GetSkusState.success(SkuResponseModel data) = _success;
  const factory GetSkusState.error(String message) = _Error;
}
