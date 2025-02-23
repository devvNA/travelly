part of 'get_total_orders_vendor_bloc.dart';

@freezed
class GetTotalOrdersVendorEvent with _$GetTotalOrdersVendorEvent {
  const factory GetTotalOrdersVendorEvent.started() = _Started;
  const factory GetTotalOrdersVendorEvent.getTotalOrders() = _GetTotalOrders;
}
