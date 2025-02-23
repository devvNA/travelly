part of 'get_vendor_user_bloc.dart';

@freezed
class GetVendorUserState with _$GetVendorUserState {
  const factory GetVendorUserState.initial() = _Initial;
  const factory GetVendorUserState.loading() = _Loading;
  const factory GetVendorUserState.success(VendorResponseModel data) = _Success;
  const factory GetVendorUserState.failure(String error) = _Failure;
}
