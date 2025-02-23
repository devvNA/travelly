import 'package:travelly/data/datasources/order_remote_datasource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_total_orders_vendor_event.dart';
part 'get_total_orders_vendor_state.dart';
part 'get_total_orders_vendor_bloc.freezed.dart';

class GetTotalOrdersVendorBloc
    extends Bloc<GetTotalOrdersVendorEvent, GetTotalOrdersVendorState> {
  final OrderRemoteDatasource datasource;

  GetTotalOrdersVendorBloc(this.datasource) : super(const _Initial()) {
    on<_GetTotalOrders>((event, emit) async {
      emit(const _Loading());
      final result = await datasource.getOrdersByUserVendorTotal();
      result.fold((l) => emit(_Error(l)), (r) => emit(_Success(r)));
    });
  }
}
