// To parse this JSON data, do
//
//     final skuResponseModel = skuResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:travelly/data/models/responses/event_response_model.dart';

SkuResponseModel skuResponseModelFromJson(String str) =>
    SkuResponseModel.fromJson(json.decode(str));

String skuResponseModelToJson(SkuResponseModel data) =>
    json.encode(data.toJson());

class SkuResponseModel {
  final String? status;
  final List<SkuModel>? data;

  SkuResponseModel({
    this.status,
    this.data,
  });

  factory SkuResponseModel.fromJson(Map<String, dynamic> json) =>
      SkuResponseModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<SkuModel>.from(
                json["data"]!.map((x) => SkuModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
