import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelly/data/datasources/event_remote_datasource.dart';
import 'package:travelly/data/models/responses/event_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_event_user_event.dart';
part 'get_event_user_state.dart';
part 'get_event_user_bloc.freezed.dart';

class GetEventUserBloc extends Bloc<GetEventUserEvent, GetEventUserState> {
  final EventRemoteDatasource datasource;

  GetEventUserBloc(this.datasource) : super(const _Initial()) {
    on<_GetEventUser>(
      (event, emit) async {
        emit(const _Loading());
        final result = await datasource.getEventsUser();
        result.fold(
          (l) => emit(_Error(l)),
          (r) => emit(_Success(r)),
        );
      },
    );
  }
}
