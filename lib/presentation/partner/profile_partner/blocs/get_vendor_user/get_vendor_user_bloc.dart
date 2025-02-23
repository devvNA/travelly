import 'package:travelly/data/datasources/vendor_remote_datasource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelly/data/models/responses/vendor_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_vendor_user_event.dart';
part 'get_vendor_user_state.dart';
part 'get_vendor_user_bloc.freezed.dart';

class GetVendorUserBloc extends Bloc<GetVendorUserEvent, GetVendorUserState> {
  final VendorRemoteDataSource dataSource;

  GetVendorUserBloc(this.dataSource) : super(const _Initial()) {
    on<_GetVendorUser>((event, emit) async {
      emit(const _Loading());
      final result = await dataSource.getVendorsUser();
      result.fold(
        (failure) => emit(_Failure(failure)),
        (data) => emit(_Success(data)),
      );
    });
  }
}
