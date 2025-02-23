part of 'get_total_orders_vendor_bloc.dart';

@freezed
class GetTotalOrdersVendorState with _$GetTotalOrdersVendorState {
  const factory GetTotalOrdersVendorState.initial() = _Initial;
  const factory GetTotalOrdersVendorState.loading() = _Loading;
  const factory GetTotalOrdersVendorState.success(String totalOrder) = _Success;
  const factory GetTotalOrdersVendorState.error(String message) = _Error;
}
