part of 'get_vendor_user_bloc.dart';

@freezed
class GetVendorUserEvent with _$GetVendorUserEvent {
  const factory GetVendorUserEvent.started() = _Started;

  const factory GetVendorUserEvent.getVendorUser() = _GetVendorUser;
}
