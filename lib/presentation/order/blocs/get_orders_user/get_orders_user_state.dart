part of 'get_orders_user_bloc.dart';

@freezed
class GetOrdersUserState with _$GetOrdersUserState {
  const factory GetOrdersUserState.initial() = _Initial;
  const factory GetOrdersUserState.loading() = _Loading;
  const factory GetOrdersUserState.success(OrderResponseModel data) = _Success;
  const factory GetOrdersUserState.error(String message) = _Error;
}
