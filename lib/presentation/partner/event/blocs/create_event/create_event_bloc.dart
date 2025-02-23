import 'package:travelly/data/datasources/event_remote_datasource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelly/data/models/requests/create_event_request_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_event_event.dart';
part 'create_event_state.dart';
part 'create_event_bloc.freezed.dart';

class CreateEventBloc extends Bloc<CreateEventEvent, CreateEventState> {
  final EventRemoteDatasource datasource;

  CreateEventBloc(this.datasource) : super(const _Initial()) {
    on<_CreateEvent>((event, emit) async {
      emit(const _Loading());
      final result = await datasource.createEvent(event.model);
      result.fold((l) => emit(_Error(l)), (r) => emit(_Success(r)));
    });
  }
}
