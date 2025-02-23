part of 'create_sku_bloc.dart';

@freezed
class CreateSkuEvent with _$CreateSkuEvent {
  const factory CreateSkuEvent.started() = _Started;
  const factory CreateSkuEvent.createSku(CreateSkuRequestModel model) =
      _CreateSku;
}
