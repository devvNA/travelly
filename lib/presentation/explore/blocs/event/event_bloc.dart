import 'dart:developer';

import 'package:travelly/data/datasources/event_remote_datasource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelly/data/models/responses/event_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_event.dart';
part 'event_state.dart';
part 'event_bloc.freezed.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final EventRemoteDatasource datasource;
  List<EventModel> events = [];
  EventBloc(this.datasource) : super(const _Initial()) {
    on<_GetEvents>((event, emit) async {
      emit(const _Loading());
      final result = await datasource.getEvents();

      result.fold(
        (l) => emit(_Error(l)),
        (r) {
          events = r.data!;
          log("Loaded events: ${events.length}");
          emit(_Success(r.data!));
        },
      );
    });

    on<_GetEventsByCategory>((event, emit) async {
      emit(const _Loading());
      if (event.category == "All") {
        emit(_Success(events));
        return;
      }

      final newEvents = events.where((element) {
        return element.eventCategory?.name == event.category;
      }).toList();

      emit(_Success(newEvents));
    });

    on<_SearchEvent>((event, emit) async {
      emit(const _Loading());
      final newEvents = events
          .where((element) =>
              element.name!.toLowerCase().contains(event.query.toLowerCase()))
          .toList();

      emit(_Success(newEvents));
    });

    on<_FetchAllFromState>((event, emit) async {
      emit(const _Loading());
      emit(_Success(events));
    });
  }
}
