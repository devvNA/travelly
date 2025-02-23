import 'package:travelly/data/datasources/sku_remote_datasource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelly/data/models/requests/create_sku_request_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_sku_event.dart';
part 'create_sku_state.dart';
part 'create_sku_bloc.freezed.dart';

class CreateSkuBloc extends Bloc<CreateSkuEvent, CreateSkuState> {
  final SkuRemoteDatasource datasource;

  CreateSkuBloc(this.datasource) : super(const CreateSkuState.initial()) {
    on<_CreateSku>((event, emit) async {
      emit(const CreateSkuState.loading());
      final result = await datasource.createSku(event.model);
      result.fold(
        (l) => emit(CreateSkuState.error(l)),
        (r) => emit(CreateSkuState.success(r)),
      );
    });
  }
}
