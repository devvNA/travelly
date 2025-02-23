import 'package:travelly/data/datasources/order_remote_datasource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelly/data/models/responses/order_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_orders_user_event.dart';
part 'get_orders_user_state.dart';
part 'get_orders_user_bloc.freezed.dart';

class GetOrdersUserBloc extends Bloc<GetOrdersUserEvent, GetOrdersUserState> {
  final OrderRemoteDatasource datasource;

  GetOrdersUserBloc(this.datasource) : super(const _Initial()) {
    on<_GetOrders>((event, emit) async {
      emit(const _Loading());
      final result = await datasource.getOrdersByUser();
      result.fold((l) => emit(_Error(l)), (r) {
        emit(_Success(r));
      });
    });
  }
}
