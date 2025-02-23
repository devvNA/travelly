part of 'check_ticket_bloc.dart';

@freezed
class CheckTicketState with _$CheckTicketState {
  const factory CheckTicketState.initial() = _Initial;
  const factory CheckTicketState.loading() = _Loading;
  const factory CheckTicketState.success(CheckTicketResponseModel data) =
      _Success;
  const factory CheckTicketState.failure(String message) = _Failure;
}
