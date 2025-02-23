part of 'get_orders_vendor_bloc.dart';

@freezed
class GetOrdersVendorEvent with _$GetOrdersVendorEvent {
  const factory GetOrdersVendorEvent.started() = _Started;
  const factory GetOrdersVendorEvent.getOrders() = _GetOrders;
}