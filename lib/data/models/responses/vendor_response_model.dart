import 'package:travelly/data/models/responses/event_response_model.dart';

class VendorResponseModel {
  final String? status;
  final String? message;
  final List<Vendor>? data;

  VendorResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory VendorResponseModel.fromJson(Map<String, dynamic> json) =>
      VendorResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Vendor>.from(json["data"]!.map((x) => Vendor.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
