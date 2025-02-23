part of 'get_orders_user_bloc.dart';

@freezed
class GetOrdersUserEvent with _$GetOrdersUserEvent {
  const factory GetOrdersUserEvent.started() = _Started;
  const factory GetOrdersUserEvent.getOrders() = _GetOrders;
}
