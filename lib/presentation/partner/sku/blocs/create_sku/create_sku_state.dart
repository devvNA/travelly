part of 'create_sku_bloc.dart';

@freezed
class CreateSkuState with _$CreateSkuState {
  const factory CreateSkuState.initial() = _Initial;
  const factory CreateSkuState.loading() = _Loading;
  const factory CreateSkuState.success(String message) = _Success;
  const factory CreateSkuState.error(String message) = _Error;
}
