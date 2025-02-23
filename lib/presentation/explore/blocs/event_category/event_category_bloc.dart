import 'package:travelly/data/datasources/event_category_remote_datasource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelly/data/models/responses/event_category_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_category_event.dart';
part 'event_category_state.dart';
part 'event_category_bloc.freezed.dart';

class EventCategoryBloc extends Bloc<EventCategoryEvent, EventCategoryState> {
  final EventCategoryRemoteDatasource datasource;
  EventCategoryBloc(this.datasource) : super(const _Initial()) {
    on<_GetEventCategories>(
      (event, emit) async {
        emit(const _Loading());
        final result = await datasource.getEventCategories();
        result.fold((l) {
          emit(_Error(l));
        }, (r) {
          emit(_Success(r));
        });
      },
    );
  }
}
