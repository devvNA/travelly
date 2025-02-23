import 'package:travelly/data/datasources/event_remote_datasource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'delete_event_event.dart';
part 'delete_event_state.dart';
part 'delete_event_bloc.freezed.dart';

class DeleteEventBloc extends Bloc<DeleteEventEvent, DeleteEventState> {
  final EventRemoteDatasource datasource;

  DeleteEventBloc(this.datasource) : super(const _Initial()) {
    on<_DeleteEvent>((event, emit) async {
      emit(const _Loading());
      final result = await datasource.deleteEvent(event.id);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Success(r)),
      );
    });
  }
}
