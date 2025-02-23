part of 'check_ticket_bloc.dart';

@freezed
class CheckTicketEvent with _$CheckTicketEvent {
  const factory CheckTicketEvent.started() = _Started;
  const factory CheckTicketEvent.checkTicket(String ticketCode) = _CheckTicket;
}
