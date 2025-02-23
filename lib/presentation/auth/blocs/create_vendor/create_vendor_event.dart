part of 'create_vendor_bloc.dart';

@freezed
class CreateVendorEvent with _$CreateVendorEvent {
  const factory CreateVendorEvent.started() = _Started;
  const factory CreateVendorEvent.createVendor(CreateVendorRequestModel model) =
      _CreateVendor;
}
