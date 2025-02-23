import 'package:travelly/data/datasources/order_remote_datasource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelly/data/models/responses/order_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_orders_vendor_event.dart';
part 'get_orders_vendor_state.dart';
part 'get_orders_vendor_bloc.freezed.dart';

class GetOrdersVendorBloc
    extends Bloc<GetOrdersVendorEvent, GetOrdersVendorState> {
  final OrderRemoteDatasource datasource;

  GetOrdersVendorBloc(this.datasource) : super(const _Initial()) {
    on<_GetOrders>((event, emit) async {
      emit(const _Loading());
      final result = await datasource.getOrdersByUserVendor();
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Success(r)),
      );
    });
  }
}
