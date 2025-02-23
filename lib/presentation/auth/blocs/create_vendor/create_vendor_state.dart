part of 'create_vendor_bloc.dart';

@freezed
class CreateVendorState with _$CreateVendorState {
  const factory CreateVendorState.initial() = _Initial;
  const factory CreateVendorState.loading() = _Loading;
  const factory CreateVendorState.success(String message) = _Success;
  const factory CreateVendorState.error(String message) = _Error;
}
