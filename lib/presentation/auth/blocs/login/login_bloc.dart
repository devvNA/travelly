import 'package:travelly/data/datasources/auth_remote_datasource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelly/data/models/requests/login_request_model.dart';
import 'package:travelly/data/models/responses/login_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRemoteDatasource datasource;

  LoginBloc(this.datasource) : super(const LoginState.initial()) {
    on<_Login>(
      (event, emit) async {
        emit(const _Loading());
        final result = await datasource.login(event.model);
        result.fold((l) {
          emit(_Error(l));
        }, (r) {
          emit(_Loaded(r));
        });
      },
    );
  }
}
