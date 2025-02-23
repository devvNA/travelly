import 'package:travelly/data/datasources/ticket_remote_datasource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelly/data/models/responses/check_ticket_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'check_ticket_event.dart';
part 'check_ticket_state.dart';
part 'check_ticket_bloc.freezed.dart';

class CheckTicketBloc extends Bloc<CheckTicketEvent, CheckTicketState> {
  final TicketRemoteDatasource datasource;
  CheckTicketBloc(this.datasource) : super(const CheckTicketState.initial()) {
    on<_CheckTicket>((event, emit) async {
      emit(const _Loading());
      final result = await datasource.checkTicket(event.ticketCode);
      result.fold(
        (l) => emit(_Failure(l)),
        (r) => emit(_Success(r)),
      );
    });
  }
}
