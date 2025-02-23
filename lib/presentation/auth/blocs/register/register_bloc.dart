import 'package:travelly/data/datasources/auth_remote_datasource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelly/data/models/requests/register_request_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_event.dart';
part 'register_state.dart';
part 'register_bloc.freezed.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRemoteDatasource datasource;

  RegisterBloc(this.datasource) : super(const RegisterState.initial()) {
    on<_Register>((event, emit) async {
      emit(const _Loading());

      final result = await datasource.register(event.model);

      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}
