part of 'get_orders_vendor_bloc.dart';

@freezed
class GetOrdersVendorState with _$GetOrdersVendorState {
  const factory GetOrdersVendorState.initial() = _Initial;
  const factory GetOrdersVendorState.loading() = _Loading;
  const factory GetOrdersVendorState.success(OrderResponseModel data) =
      _Success;
  const factory GetOrdersVendorState.error(String message) = _Error;
}
