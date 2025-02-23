import 'package:travelly/data/datasources/sku_remote_datasource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelly/data/models/responses/sku_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_skus_event.dart';
part 'get_skus_state.dart';
part 'get_skus_bloc.freezed.dart';

class GetSkusBloc extends Bloc<GetSkusEvent, GetSkusState> {
  final SkuRemoteDatasource datasource;

  GetSkusBloc(this.datasource) : super(const GetSkusState.initial()) {
    on<_GetSkus>((event, emit) async {
      emit(const GetSkusState.loading());
      final result = await datasource.getSkusUser();
      result.fold(
        (l) => emit(GetSkusState.error(l)),
        (r) => emit(GetSkusState.success(r)),
      );
    });
  }
}
